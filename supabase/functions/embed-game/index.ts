import { createClient } from "jsr:@supabase/supabase-js@2";

// Setup the AI Session (Uses the free gte-small model built into Supabase Edge)
const session = new Supabase.ai.Session("gte-small");

Deno.serve(async (req) => {
  // 1. Parse the Webhook Payload
  const payload = await req.json();
  const { record } = payload;

  // 2. Construct the "Searchable Text"
  // We combine important fields so the AI understands the full context.
  // Handle nulls gracefully.
  // 2. Construct the "Searchable Text"
  const input = `
    Title: ${record.name ?? ""}
    Genre: ${record.genres ?? ""}
    Tags: ${record.tags ?? ""}
    Platforms: ${record.platforms ?? ""}
    Requirements: ${record.requirements ? JSON.stringify(record.requirements) : "Not specified"}
    Stores: ${record.stores ?? ""}
    Release Date: ${record.released ?? ""}  
    ESRB: ${record.esrb_rating ?? ""}
  `.trim();

  if (!input) {
    return new Response("No text to embed", { status: 200 });
  }

  // 3. Generate Embedding (Free, runs on CPU)
  // This produces a vector of 384 numbers
  const embedding = await session.run(input, {
    mean_pool: true,
    normalize: true,
  });

  // 4. Initialize Supabase Client (Service Role needed to bypass RLS if active)
  const supabase = createClient(
    Deno.env.get("SUPABASE_URL") ?? "",
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? ""
  );

  // 5. Update the row with the new embedding
  const { error } = await supabase.from("games").update({ embedding }).eq("id", record.id);

  if (error) {
    console.error("Update error:", error);
    return new Response(JSON.stringify(error), { status: 500 });
  }

  return new Response("Embedding generated", { status: 200 });
});
