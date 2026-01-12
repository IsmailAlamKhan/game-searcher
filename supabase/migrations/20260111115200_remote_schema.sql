create extension if not exists "hypopg" with schema "extensions";

create extension if not exists "index_advisor" with schema "extensions";

drop extension if exists "pg_net";

create extension if not exists "pg_net" with schema "public";

create extension if not exists "vector" with schema "public";

revoke delete on table "public"."tags" from "anon";

revoke insert on table "public"."tags" from "anon";

revoke references on table "public"."tags" from "anon";

revoke select on table "public"."tags" from "anon";

revoke trigger on table "public"."tags" from "anon";

revoke truncate on table "public"."tags" from "anon";

revoke update on table "public"."tags" from "anon";

revoke delete on table "public"."tags" from "authenticated";

revoke insert on table "public"."tags" from "authenticated";

revoke references on table "public"."tags" from "authenticated";

revoke select on table "public"."tags" from "authenticated";

revoke trigger on table "public"."tags" from "authenticated";

revoke truncate on table "public"."tags" from "authenticated";

revoke update on table "public"."tags" from "authenticated";

revoke delete on table "public"."tags" from "service_role";

revoke insert on table "public"."tags" from "service_role";

revoke references on table "public"."tags" from "service_role";

revoke select on table "public"."tags" from "service_role";

revoke trigger on table "public"."tags" from "service_role";

revoke truncate on table "public"."tags" from "service_role";

revoke update on table "public"."tags" from "service_role";

alter table "public"."tags" drop constraint "tags_pkey";

drop index if exists "public"."tags_pkey";

drop table "public"."tags";

alter table "public"."games" add column "requirements" jsonb;

alter table "public"."games" alter column "metacritic" set data type double precision using "metacritic"::double precision;

alter table "public"."games" disable row level security;

CREATE INDEX games_esrb_rating_idx ON public.games USING btree (esrb_rating);

CREATE INDEX games_genres_idx ON public.games USING btree (genres);

CREATE INDEX games_metacritic_idx ON public.games USING btree (metacritic);

CREATE INDEX games_name_idx ON public.games USING btree (name);

CREATE INDEX games_parent_platforms_idx ON public.games USING btree (parent_platforms);

CREATE INDEX games_platforms_idx ON public.games USING btree (platforms);

CREATE INDEX games_rating_idx ON public.games USING btree (rating);

CREATE INDEX games_rating_top_idx ON public.games USING btree (rating_top);

CREATE INDEX games_ratings_count_idx ON public.games USING btree (ratings_count);

CREATE INDEX games_released_idx ON public.games USING btree (released);

CREATE INDEX games_reviews_count_idx ON public.games USING btree (reviews_count);

CREATE INDEX games_slug_idx ON public.games USING btree (slug);

CREATE INDEX games_stores_idx ON public.games USING btree (stores);

CREATE INDEX games_tags_idx ON public.games USING btree (tags);

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.match_games(query_embedding public.vector, match_threshold double precision DEFAULT 0.1, match_count integer DEFAULT 50, filter jsonb DEFAULT '{}'::jsonb)
 RETURNS TABLE(id bigint, content text, metadata jsonb, similarity double precision)
 LANGUAGE plpgsql
AS $function$
begin
  return query
  select
    games.id,
    -- Map the game name to 'content' so n8n sees it as the main text
    games.name as content, 
    
    -- Pack all other info into a JSON object for the AI to read
    jsonb_build_object(
        'id', games.id,
        'name', games.name,
        'genres', games.genres,
        'platforms', games.platforms,
        'rating', games.rating,
        'released', games.released,
        'background_image', games.background_image,
        'requirements', games.requirements,
        'esrb_rating', games.esrb_rating
    ) as metadata,
    
    1 - (games.embedding <=> query_embedding) as similarity
  from games
  where 1 - (games.embedding <=> query_embedding) > match_threshold
  order by similarity desc
  limit match_count;
end;
$function$
;

CREATE OR REPLACE FUNCTION public.trigger_embed_game_func()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
begin
  -- Send the HTTP request asynchronously
  perform net.http_post(
    url := 'https://yfamzhxnyzhatqjqcntl.supabase.co/functions/v1/embed-game',
    
    -- Wrap the 'NEW' row data in a JSON object: { "record": { "id": 1, "name": "Halo", ... } }
    body := jsonb_build_object('record', NEW),
    
    -- Headers
    headers := '{"Content-Type": "application/json"}'::jsonb
  );
  
  return new;
end;
$function$
;

CREATE TRIGGER embed_game_webhook AFTER INSERT ON public.games FOR EACH ROW EXECUTE FUNCTION public.trigger_embed_game_func();


