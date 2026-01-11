
  create table "public"."games" (
    "id" bigint not null,
    "slug" text,
    "name" text,
    "released" text,
    "tba" boolean,
    "background_image" text,
    "rating" double precision,
    "rating_top" bigint,
    "ratings_count" bigint,
    "reviews_text_count" bigint,
    "metacritic" bigint,
    "suggestions_count" bigint,
    "reviews_count" bigint,
    "platforms" text,
    "parent_platforms" text,
    "genres" text,
    "stores" text,
    "tags" text,
    "esrb_rating" text
      );


alter table "public"."games" enable row level security;

CREATE UNIQUE INDEX games_pkey ON public.games USING btree (id);

alter table "public"."games" add constraint "games_pkey" PRIMARY KEY using index "games_pkey";

grant delete on table "public"."games" to "anon";

grant insert on table "public"."games" to "anon";

grant references on table "public"."games" to "anon";

grant select on table "public"."games" to "anon";

grant trigger on table "public"."games" to "anon";

grant truncate on table "public"."games" to "anon";

grant update on table "public"."games" to "anon";

grant delete on table "public"."games" to "authenticated";

grant insert on table "public"."games" to "authenticated";

grant references on table "public"."games" to "authenticated";

grant select on table "public"."games" to "authenticated";

grant trigger on table "public"."games" to "authenticated";

grant truncate on table "public"."games" to "authenticated";

grant update on table "public"."games" to "authenticated";

grant delete on table "public"."games" to "postgres";

grant insert on table "public"."games" to "postgres";

grant references on table "public"."games" to "postgres";

grant select on table "public"."games" to "postgres";

grant trigger on table "public"."games" to "postgres";

grant truncate on table "public"."games" to "postgres";

grant update on table "public"."games" to "postgres";

grant delete on table "public"."games" to "service_role";

grant insert on table "public"."games" to "service_role";

grant references on table "public"."games" to "service_role";

grant select on table "public"."games" to "service_role";

grant trigger on table "public"."games" to "service_role";

grant truncate on table "public"."games" to "service_role";

grant update on table "public"."games" to "service_role";

grant delete on table "public"."tags" to "postgres";

grant insert on table "public"."tags" to "postgres";

grant references on table "public"."tags" to "postgres";

grant select on table "public"."tags" to "postgres";

grant trigger on table "public"."tags" to "postgres";

grant truncate on table "public"."tags" to "postgres";

grant update on table "public"."tags" to "postgres";


