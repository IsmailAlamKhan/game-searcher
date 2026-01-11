import csv
import os


def clean_tags():
    input_file = "tags.csv"
    output_file = "tags_cleaned.csv"

    # Get absolute path relative to project root
    script_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.dirname(script_dir)
    input_path = os.path.join(project_root, input_file)
    output_path = os.path.join(project_root, output_file)

    if not os.path.exists(input_path):
        print(f"Error: {input_path} does not exist.")
        return

    seen_ids = set()
    cleaned_rows = []
    removed_duplicates = 0
    removed_low_count = 0

    print(f"Reading {input_path}...")
    with open(input_path, mode="r", encoding="utf-8", newline="") as csvfile:
        reader = csv.DictReader(csvfile)
        fieldnames = reader.fieldnames

        for row in reader:
            tag_id = row.get("id")
            try:
                # RAWG uses games_count to indicate how many games have this tag
                gc = row.get("games_count")
                games_count = int(gc) if gc and gc.strip() else 0
            except (ValueError, TypeError):
                games_count = 0

            # Check for duplicates by ID
            if tag_id in seen_ids:
                removed_duplicates += 1
                continue

            # Check for games_count < 5
            if games_count < 5:
                removed_low_count += 1
                continue

            seen_ids.add(tag_id)
            cleaned_rows.append(row)

    print(f"Writing cleaned data to {output_path}...")
    with open(output_path, mode="w", encoding="utf-8", newline="") as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(cleaned_rows)

    print(f"\nCleaning stats:")
    print(f"- Removed {removed_duplicates} duplicate IDs.")
    print(f"- Removed {removed_low_count} tags with less than 5 games.")
    print(f"- Total tags remaining: {len(cleaned_rows)}")

    print(f"\nCleaned data saved to: {output_path}")
    print(f"To replace the original file, run: move {output_path} {input_path}")


if __name__ == "__main__":
    clean_tags()
