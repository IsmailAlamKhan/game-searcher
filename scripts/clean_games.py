import csv
import json
import os


def clean_csv(input_filename: str, output_filename: str):
    if not os.path.exists(input_filename):
        print(f"File {input_filename} not found.")
        return

    print(f"Cleaning {input_filename} and saving to {output_filename}...")
    seen_ids = set()
    cleaned_data = []
    removed_duplicates = 0
    removed_low_rating = 0

    with open(input_filename, "r", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        fieldnames = reader.fieldnames
        for row in reader:
            game_id = row.get("id")
            try:
                rating = float(row.get("rating", 0))
            except (ValueError, TypeError):
                rating = 0

            # Rule 1: Remove duplicates
            if game_id in seen_ids:
                removed_duplicates += 1
                continue

            # Rule 2: Remove < 20% rating (rating < 1 out of 5)
            if (rating / 5) * 100 < 20:
                removed_low_rating += 1
                continue

            seen_ids.add(game_id)
            cleaned_data.append(row)

    with open(output_filename, "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(cleaned_data)

    print(f"Finished cleaning CSV:")
    print(f"- Original file: {input_filename}")
    print(f"- Cleaned file: {output_filename}")
    print(f"- Total games kept: {len(cleaned_data)}")
    print(f"- Duplicates removed: {removed_duplicates}")
    print(f"- Low ratings (<20%) removed: {removed_low_rating}")


def clean_json(input_filename: str, output_filename: str):
    if not os.path.exists(input_filename):
        print(f"File {input_filename} not found.")
        return

    print(f"Cleaning {input_filename} and saving to {output_filename}...")
    with open(input_filename, "r", encoding="utf-8") as f:
        data = json.load(f)

    seen_ids = set()
    cleaned_data = []
    removed_duplicates = 0
    removed_low_rating = 0

    for game in data:
        game_id = game.get("id")
        rating = game.get("rating", 0)

        if game_id in seen_ids:
            removed_duplicates += 1
            continue

        if (rating / 5) * 100 < 20:
            removed_low_rating += 1
            continue

        seen_ids.add(game_id)
        cleaned_data.append(game)

    with open(output_filename, "w", encoding="utf-8") as f:
        json.dump(cleaned_data, f, indent=4)

    print(f"Finished cleaning JSON:")
    print(f"- Original file: {input_filename}")
    print(f"- Cleaned file: {output_filename}")
    print(f"- Total games kept: {len(cleaned_data)}")
    print(f"- Duplicates removed: {removed_duplicates}")
    print(f"- Low ratings (<20%) removed: {removed_low_rating}")


def main():
    if os.path.exists("games.csv"):
        clean_csv("games.csv", "games_cleaned.csv")

    if os.path.exists("games.json"):
        clean_json("games.json", "games_cleaned.json")


if __name__ == "__main__":
    main()
