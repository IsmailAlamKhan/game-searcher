import json
import math
import os
import time
from pathlib import Path

from dotenv import load_dotenv

from supabase import Client, create_client

load_dotenv()

# --- CONFIGURATION ---
SUPABASE_URL = os.getenv("SUPABASE_URL")
SUPABASE_KEY = os.getenv("SUPABASE_PUBLISHABLE_KEY")
JSONL_FILE = "games.jsonl"
PROGRESS_FILE = "upload_progress.txt"
FAILED_GAMES_FILE = "failed_games.log"
CHUNK_SIZE = 50  # Number of rows to upload at once
SLEEP_TIME = 2  # Seconds to pause between chunks
WATCH_INTERVAL = 5  # Seconds to wait for new data when watching

# Initialize Client
supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)


def log_failed_game(game_id, error_msg):
    """Log a failed game ID with error message to file"""
    from datetime import datetime

    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    with open(FAILED_GAMES_FILE, "a", encoding="utf-8") as f:
        f.write(f"[{timestamp}] Game ID: {game_id} | Error: {error_msg}\n")


def get_last_uploaded_line():
    """Get the line number of the last successfully uploaded game"""
    try:
        with open(PROGRESS_FILE, "r") as f:
            return int(f.read().strip())
    except (FileNotFoundError, ValueError):
        return 0


def set_last_uploaded_line(line_num):
    """Save the line number of the last successfully uploaded game"""
    with open(PROGRESS_FILE, "w") as f:
        f.write(str(line_num))


def clean_record(record):
    """
    Clean a single game record to ensure it's compatible with Supabase.
    - Converts NaN and infinity values to None
    - Ensures metacritic is an integer or None
    """
    cleaned = {}
    for key, value in record.items():
        # Handle float NaN/infinity values
        if isinstance(value, float) and (math.isnan(value) or math.isinf(value)):
            cleaned[key] = None
        # Convert metacritic to int if it's a valid number
        elif key == "metacritic" and value is not None:
            try:
                cleaned[key] = int(value) if value != "" else None
            except (ValueError, TypeError):
                cleaned[key] = None
        else:
            cleaned[key] = value

    return cleaned


def read_games_from_line(start_line, max_count=None):
    """Read games from JSONL file starting from a specific line"""
    games = []
    line_num = 0

    try:
        with open(JSONL_FILE, "r", encoding="utf-8") as f:
            for line in f:
                line_num += 1
                if line_num <= start_line:
                    continue
                if max_count and len(games) >= max_count:
                    break

                line = line.strip()
                if line:
                    try:
                        game = json.loads(line)
                        games.append(game)
                    except json.JSONDecodeError as e:
                        print(f"⚠️  Skipping invalid JSON at line {line_num}: {e}")
                        continue

        return games, line_num
    except FileNotFoundError:
        return [], 0


def get_existing_game_ids():
    """Fetch all existing game IDs from Supabase"""
    try:
        print("🔍 Fetching existing game IDs from database...")
        existing_ids = set()
        page_size = 1000
        offset = 0

        while True:
            response = (
                supabase.table("games")
                .select("id")
                .range(offset, offset + page_size - 1)
                .execute()
            )

            if not response.data:
                break

            batch_ids = {game["id"] for game in response.data}
            existing_ids.update(batch_ids)

            if len(response.data) < page_size:
                break

            offset += page_size

        print(f"✅ Found {len(existing_ids)} existing games in database")
        return existing_ids

    except Exception as e:
        print(f"⚠️  Error fetching existing game IDs: {e}")
        print("⚠️  Continuing without filtering (may cause duplicates)")
        return set()


def upload_batch(games, start_line, existing_ids=None):
    """Upload a batch of games to Supabase, skipping those already uploaded"""
    if not games:
        return 0

    # Clean each record
    records = [clean_record(game) for game in games]

    # Filter out games that already exist
    if existing_ids is not None:
        original_count = len(records)
        records = [r for r in records if r.get("id") not in existing_ids]
        skipped_count = original_count - len(records)

        if skipped_count > 0:
            print(f"⏭️  Skipped {skipped_count} games (already in database)")

    if not records:
        # All games in this batch were already uploaded
        end_line = start_line + len(games)
        set_last_uploaded_line(end_line)
        return len(games)

    try:
        # Try to upsert the entire batch
        supabase.table("games").upsert(records).execute()
        uploaded_count = len(records)
        total_processed = len(games)
        end_line = start_line + total_processed
        set_last_uploaded_line(end_line)
        print(
            f"✅ Uploaded {uploaded_count} new games (lines {start_line + 1} to {end_line})"
        )

        # Add newly uploaded IDs to the existing set
        if existing_ids is not None:
            for record in records:
                existing_ids.add(record.get("id"))

        return total_processed

    except Exception as batch_error:
        # Batch upload failed, try uploading individually to identify problematic records
        print(f"⚠️  Batch upload failed: {batch_error}")
        print(f"🔄 Retrying {len(records)} games individually...")

        successful_uploads = 0
        failed_uploads = 0

        for record in records:
            game_id = record.get("id", "unknown")
            try:
                supabase.table("games").upsert([record]).execute()
                successful_uploads += 1

                # Add to existing IDs set
                if existing_ids is not None:
                    existing_ids.add(game_id)

            except Exception as individual_error:
                failed_uploads += 1
                error_msg = str(individual_error)
                log_failed_game(game_id, error_msg)
                print(f"❌ Failed to upload game ID {game_id}: {error_msg[:100]}")

        # Update progress for all games processed (successful + failed)
        total_processed = len(games)
        end_line = start_line + total_processed
        set_last_uploaded_line(end_line)

        if successful_uploads > 0:
            print(f"✅ Successfully uploaded {successful_uploads} games individually")
        if failed_uploads > 0:
            print(
                f"❌ Failed to upload {failed_uploads} games (logged to {FAILED_GAMES_FILE})"
            )

        return total_processed


def watch_and_upload():
    """Watch the JSONL file and upload new games as they appear"""
    print("👀 Starting watch mode - monitoring for new games...")
    print(f"📁 Watching file: {JSONL_FILE}")
    print(f"📊 Progress tracked in: {PROGRESS_FILE}")
    print(f"🔄 Checking for new games every {WATCH_INTERVAL} seconds")
    print("-" * 60)

    # Fetch existing game IDs from database
    existing_ids = get_existing_game_ids()
    print("-" * 60)

    last_uploaded_line = get_last_uploaded_line()
    print(f"📍 Resuming from line {last_uploaded_line}")

    total_uploaded = 0
    consecutive_empty_checks = 0

    while True:
        # Read new games since last upload
        games, current_line = read_games_from_line(last_uploaded_line, CHUNK_SIZE)

        if games:
            consecutive_empty_checks = 0
            uploaded = upload_batch(games, last_uploaded_line, existing_ids)
            if uploaded > 0:
                total_uploaded += uploaded
                last_uploaded_line += uploaded
                print(f"📈 Total processed this session: {total_uploaded}")

            # Pause between chunks
            time.sleep(SLEEP_TIME)
        else:
            consecutive_empty_checks += 1

            # Check if extraction might be complete
            if consecutive_empty_checks == 1:
                print(
                    f"⏳ No new games found. Waiting {WATCH_INTERVAL}s for more data..."
                )
            elif consecutive_empty_checks >= 12:  # 1 minute of no new data
                print("⏹️  No new games for 1 minute. Extraction might be complete.")
                print(f"✅ Session complete! Total processed: {total_uploaded}")
                print(
                    "💡 Press Ctrl+C to stop watching, or continue waiting for more data..."
                )

            time.sleep(WATCH_INTERVAL)


def upload_all():
    """Upload all games from the JSONL file (non-watch mode)"""
    print("📤 Starting full upload from JSONL file...")
    print(f"📁 Reading from: {JSONL_FILE}")
    print("-" * 60)

    # Fetch existing game IDs from database
    existing_ids = get_existing_game_ids()
    print("-" * 60)

    last_uploaded_line = get_last_uploaded_line()
    print(f"📍 Resuming from line {last_uploaded_line}")

    total_uploaded = 0

    while True:
        games, current_line = read_games_from_line(last_uploaded_line, CHUNK_SIZE)

        if not games:
            break

        uploaded = upload_batch(games, last_uploaded_line, existing_ids)
        if uploaded > 0:
            total_uploaded += uploaded
            last_uploaded_line += uploaded

        time.sleep(SLEEP_TIME)

    print(f"\n🎉 Upload Complete! Total processed: {total_uploaded}")
    print(
        "Note: The 'embedding' column might take a few seconds to populate for the last batch."
    )


if __name__ == "__main__":
    # Check if JSONL file exists
    if not Path(JSONL_FILE).exists():
        print(f"❌ Error: Could not find file '{JSONL_FILE}'")
        print("💡 Make sure extract_games.py is running first!")
        exit(1)

    print("=" * 60)
    print("🎮 Game Uploader - JSONL to Supabase")
    print("=" * 60)
    print()
    print(f"📝 Failed uploads will be logged to: {FAILED_GAMES_FILE}")
    print()
    print("Choose mode:")
    print("  1. Watch mode (continuously monitor and upload new games)")
    print("  2. Upload all (upload entire file once)")
    print()

    try:
        choice = input("Enter choice (1 or 2, default: 1): ").strip() or "1"

        if choice == "1":
            watch_and_upload()
        elif choice == "2":
            upload_all()
        else:
            print("Invalid choice. Defaulting to watch mode...")
            watch_and_upload()

    except KeyboardInterrupt:
        print("\n\n⚠️  Upload interrupted by user.")
        last_line = get_last_uploaded_line()
        print(f"📍 Progress saved at line {last_line}")
        print("💡 Run again to resume from where you left off!")
