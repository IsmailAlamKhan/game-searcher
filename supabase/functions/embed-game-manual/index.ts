// Setup the AI Session (Uses the free gte-small model built into Supabase Edge)
const session = new Supabase.ai.Session("gte-small");

Deno.serve(async (req) => {
  try {
    const { records } = await req.json();

    if (!records || !Array.isArray(records)) {
      return new Response(JSON.stringify({ error: "Invalid input: expected 'records' array" }), {
        status: 400,
        headers: { "Content-Type": "application/json" },
      });
    }

    const embeddings = [];

    for (const record of records) {
      // Optimize input: only include high-signal fields to reduce token count and CPU usage
      const parts = [
        record.name ? `Title: ${record.name}` : null,
        record.genres ? `Genres: ${record.genres}` : null,
        record.tags ? `Tags: ${record.tags}` : null,
        record.platforms ? `Platforms: ${record.platforms}` : null,
        record.released ? `Release Date: ${record.released}` : null,
        record.esrb_rating ? `ESRB: ${record.esrb_rating}` : null,
      ].filter(Boolean);

      const input = parts.join(" | ");

      if (!input) {
        embeddings.push(null);
        continue;
      }

      // Process sequentially to stay under CPU burst limits
      const embedding = await session.run(input, {
        mean_pool: true,
        normalize: true,
      });

      // Ensure we return a standard array of numbers
      embeddings.push(Array.from(embedding));
    }

    return new Response(JSON.stringify({ embeddings }), {
      status: 200,
      headers: { "Content-Type": "application/json" },
    });
  } catch (error) {
    console.error("Error generating embeddings:", error);
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { "Content-Type": "application/json" },
    });
  }
});
