import json
import time
from typing import Any
from urllib.parse import parse_qs, urlparse

import requests

BASE_URL = "https://api.rawg.io/api/"
API_KEY = "13437101070348cfb51b1f6f032a23ed"
FILE = "tags.json"


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
    if not data.get("next"):
        return {
            "next": None,
            "results": [
                {
                    "name": tag["name"],
                    "slug": tag["slug"],
                }
                for tag in data["results"]
            ],
        }

    next_page = parse_qs(urlparse(data.get("next")).query).get("page")[0]
    return {
        "next": next_page,
        "results": [
            {
                "name": tag["name"],
                "slug": tag["slug"],
            }
            for tag in data["results"]
        ],
    }


tags = []


def main():
    global tags
    print("Extracting tags...")

    tags_res = extract_tags()
    next = tags_res.get("next")
    tags.extend(tags_res["results"])

    while next:
        print("Sleeping for 2 second to avoid rate limiting")
        time.sleep(2)
        try:
            tags_res = extract_tags(int(next))
        except Exception as e:
            print(f"Failed at page {next} because {e} will extract {len(tags)} tags")
            break
        tags.extend(tags_res["results"])
        print(f"Extracted {len(tags)} tags")
        next = tags_res.get("next")

    with open(FILE, "w") as f:
        print("Saving tags...")
        json.dump(tags, f, indent=4)


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\nExtracted", len(tags), "tags")
        with open(FILE, "w") as f:
            json.dump(tags, f, indent=4)
