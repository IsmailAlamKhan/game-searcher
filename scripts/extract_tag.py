import csv
import json
import time
from typing import Any
from urllib.parse import parse_qs, urlparse

import requests

BASE_URL = "https://api.rawg.io/api/"
API_KEY = "13437101070348cfb51b1f6f032a23ed"
format_choice = "json"


def extract_tags(page: int = 1) -> dict[str, Any]:
    print("Extracting page", page)
    url = BASE_URL + "tags"
    params = {
        "key": API_KEY,
        "page_size": 40,
        "page": page,
    }
    response = requests.get(url, params=params)
    if response.status_code != 200:
        print(response.text)
        raise Exception("Failed to extract tags")
    data = response.json()
    print(f"Extracted page {page} {len(data['results'])} tags")

    results = [
        {
            "id": tag.get("id"),
            "name": tag.get("name"),
            "slug": tag.get("slug"),
            "games_count": tag.get("games_count"),
            "image_background": tag.get("image_background"),
            "language": tag.get("language"),
        }
        for tag in data["results"]
    ]

    next_page = None
    if data.get("next"):
        query = parse_qs(urlparse(data.get("next")).query)
        next_page = query.get("page", [None])[0]

    return {
        "next": next_page,
        "results": results,
    }


tags = []


def save_data(format_choice: str):
    global tags
    filename = f"tags.{format_choice.lower()}"
    print(f"Saving tags to {filename}...")

    if format_choice.lower() == "json":
        with open(filename, "w", encoding="utf-8") as f:
            json.dump(tags, f, indent=4)
    elif format_choice.lower() == "csv":
        if not tags:
            print("No tags to save.")
            return
        keys = tags[0].keys()
        with open(filename, "w", newline="", encoding="utf-8") as f:
            writer = csv.DictWriter(f, fieldnames=keys)
            writer.writeheader()
            writer.writerows(tags)
    print("Done!")


def main():
    global tags
    global format_choice
    format_choice = input("Select output format (json/csv): ").strip().lower()

    while format_choice not in ["json", "csv"]:
        print("Invalid format. Defaulting to json.")
        format_choice = "json"

    print("Extracting tags...")

    tags_res = extract_tags()
    next_page = tags_res.get("next")
    tags.extend(tags_res["results"])

    while next_page:
        print("Sleeping for 1 second to avoid rate limiting")
        time.sleep(1)
        try:
            tags_res = extract_tags(int(next_page))
        except Exception as e:
            print(
                f"Failed at page {next_page} because {e}. Will save {len(tags)} tags."
            )
            break
        tags.extend(tags_res["results"])
        print(f"Extracted {len(tags)} tags")
        next_page = tags_res.get("next")

    save_data(format_choice)


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\nInterrupted. Saving current progress...")
        save_data(format_choice)
