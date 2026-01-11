import json
import re
import time
from typing import Any
from urllib.parse import parse_qs, urlparse

import requests

BASE_URL = "https://api.rawg.io/api/"
API_KEY = "13437101070348cfb51b1f6f032a23ed"
last_fetched_page = 0


def get_last_page_from_device():
    try:
        with open("last_fetched_page.txt", "r") as f:
            page = int(f.read())
            print(f"Last fetched page: {page}")
            return page
    except FileNotFoundError:
        return 0
    except ValueError:
        return 0


def parse_specs(text: str) -> dict[str, str]:
    if not text:
        return {}

    specs = {}
    key_map = {
        "OS": "OS",
        "Processor": "Processor",
        "CPU": "Processor",
        "RAM": "Memory",
        "GPU": "Graphics",
        "Available Storage": "Storage",
        "Memory": "Memory",
        "Graphics": "Graphics",
        "Video Card": "Graphics",
        "DirectX": "DirectX",
        "Storage": "Storage",
        "Hard Disk Space": "Storage",
        "Hard Drive": "Storage",
        "Sound Card": "Sound Card",
        "Additional Notes": "Additional Notes",
        "Additional": "Additional Notes",
        "Other Requirements": "Additional Notes",
        "Other": "Additional Notes",
        "Partner Requirements": "Partner",
        "Partner": "Partner",
        "iPhone": "iPhone",
        "iPad": "iPad",
        "iPod": "iPod",
        "Watch": "Watch",
    }

    remaining = text
    # Strip HTML tags initially to avoid them being caught between keys
    remaining = re.sub(r"<[^>]*>", " ", remaining)
    # Remove initial "Minimum:" or "Recommended:"
    remaining = re.sub(
        r"^(Minimum|Recommended):", "", remaining, flags=re.IGNORECASE
    ).strip()

    apple_keys = {"iPhone", "iPad", "iPod", "Watch"}
    sorted_keys = sorted(key_map.keys(), key=len, reverse=True)

    # Build regex pattern
    patterns = []
    for k in sorted_keys:
        if k in apple_keys:
            patterns.append(re.escape(k))
        else:
            patterns.append(re.escape(k) + ":")

    pattern = "(" + "|".join(patterns) + ")"
    regex = re.compile(pattern, re.IGNORECASE)

    matches = list(regex.finditer(remaining))

    if not matches:
        # Clean up whitespace for general text
        return {"General": re.sub(r"\s+", " ", remaining).strip()}

    for i in range(len(matches)):
        match = matches[i]
        raw_match = match.group(1)
        raw_key = raw_match.replace(":", "").strip()

        # Find the normalized key (case insensitive check)
        normalized_key = raw_key
        for k, v in key_map.items():
            if k.lower() == raw_key.lower():
                normalized_key = v
                break

        start = match.end()
        end = matches[i + 1].start() if i + 1 < len(matches) else len(remaining)

        value = remaining[start:end].strip()

        # Clean up whitespace and remaining artifacts
        value = re.sub(r"\s+", " ", value).strip()
        if value.startswith(",") or value.startswith("-"):
            value = value[1:].strip()
        if value.endswith(","):
            value = value[:-1].strip()

        if value:
            if normalized_key in specs:
                specs[normalized_key] = f"{specs[normalized_key]} / {value}"
            else:
                specs[normalized_key] = value

    return specs


def extract_games(page: int = 1) -> dict[str, Any]:
    print(f"Extracting page {page}...")
    url = BASE_URL + "games"
    params = {
        "key": API_KEY,
        "page_size": 40,
        "page": page,
    }
    try:
        response = requests.get(url, params=params)
        if response.status_code != 200:
            print(response.text)
            raise Exception(f"Failed to extract games: {response.status_code}")
        data = response.json()
    except Exception as e:
        print(f"Request failed: {e}")
        raise

    print(f"Extracted page {page} {len(data['results'])} games")

    results = []
    for game in data["results"]:
        # Process platforms: comma separated names
        platforms_list = game.get("platforms", [])
        platforms = ", ".join(
            [p["platform"]["name"] for p in platforms_list if "platform" in p]
        )

        # Process parent_platforms: comma separated names
        parent_platforms = ", ".join(
            [
                p["platform"]["name"]
                for p in game.get("parent_platforms", [])
                if "platform" in p
            ]
        )

        # Process genres: comma separated names
        genres = ", ".join([g["name"] for g in game.get("genres", []) if "name" in g])

        # Process stores: comma separated store names
        stores = ", ".join(
            [s["store"]["name"] for s in game.get("stores", []) if "store" in s]
        )

        # Process tags: comma separated names
        tags = ", ".join([t["name"] for t in game.get("tags", []) if "name" in t])

        # Extract requirements
        pc_requirements = {}
        for p in platforms_list:
            if p.get("platform", {}).get("slug") == "pc":
                reqs = p.get("requirements_en")
                if reqs:
                    if reqs.get("minimum"):
                        pc_requirements["minimum"] = parse_specs(
                            reqs.get("minimum", "")
                        )
                    if reqs.get("recommended"):
                        pc_requirements["recommended"] = parse_specs(
                            reqs.get("recommended", "")
                        )
                break

        esrb = game.get("esrb_rating")
        esrb_name = esrb.get("name") if esrb else None

        results.append(
            {
                "id": game.get("id"),
                "slug": game.get("slug"),
                "name": game.get("name"),
                "released": game.get("released"),
                "tba": game.get("tba"),
                "background_image": game.get("background_image"),
                "rating": game.get("rating"),
                "rating_top": game.get("rating_top"),
                "ratings_count": game.get("ratings_count"),
                "reviews_text_count": game.get("reviews_text_count"),
                "metacritic": game.get("metacritic"),
                "suggestions_count": game.get("suggestions_count"),
                "reviews_count": game.get("reviews_count"),
                "platforms": platforms,
                "parent_platforms": parent_platforms,
                "genres": genres,
                "stores": stores,
                "tags": tags,
                "esrb_rating": esrb_name,
                "requirements": json.dumps(pc_requirements)
                if pc_requirements
                else None,
            }
        )

    next_page = None
    if data.get("next"):
        query = parse_qs(urlparse(data.get("next")).query)
        next_page_list = query.get("page")
        if next_page_list:
            next_page = next_page_list[0]
    # Store the current page number to device
    global last_fetched_page
    last_fetched_page = page
    with open("last_fetched_page.txt", "w") as f:
        f.write(str(page))

    return {
        "next": next_page,
        "results": results,
    }


games_count = 0
JSONL_FILE = "games.jsonl"


def append_games_to_file(games: list[dict]):
    """Append games to JSONL file immediately (one JSON object per line)"""
    global games_count
    with open(JSONL_FILE, "a", encoding="utf-8") as f:
        for game in games:
            # Convert requirements string back to object for clean JSON output
            item = game.copy()
            if item.get("requirements"):
                item["requirements"] = json.loads(item["requirements"])
            f.write(json.dumps(item) + "\n")
            games_count += 1
    print(f"✅ Wrote {len(games)} games to {JSONL_FILE} (Total: {games_count})")


def main():
    global last_fetched_page

    print("🚀 Starting continuous game extraction to JSONL...")
    print(f"📁 Writing to: {JSONL_FILE}")
    print(f"📄 Tracking progress in: last_fetched_page.txt")
    print("-" * 60)

    games_res = extract_games(last_fetched_page + 1)
    next_page = games_res.get("next")
    append_games_to_file(games_res["results"])

    while next_page:
        # Sleep to avoid rate limiting
        print("Sleeping for 5 seconds...")
        time.sleep(5)
        try:
            games_res = extract_games(int(next_page))
            append_games_to_file(games_res["results"])
            next_page = games_res.get("next")
        except Exception as e:
            print(f"Extraction stopped unexpectedly: {e}")
            print("Waiting 1 min before retrying...")
            time.sleep(60)
            continue

    print(f"\n✅ Extraction complete! Total games extracted: {games_count}")


if __name__ == "__main__":
    try:
        last_fetched_page = get_last_page_from_device()
        main()
    except KeyboardInterrupt:
        print(f"\n⚠️  Interrupted. Progress saved. Total games extracted: {games_count}")
