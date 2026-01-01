import logging
from typing import Any, List, Optional
from urllib.parse import parse_qs, urlparse

import requests
from core.config import settings
from core.models import (
    GameRecord,
    Screenshot,
    SearchQuery,
    Store,
    platformColors,
    storeColors,
)
from fastapi import HTTPException

logger = logging.getLogger()


class RawgClient:
    BASE_URL = "https://api.rawg.io/api"

    def __init__(self, api_key: str = None):
        self.api_key = api_key or settings.RAWG_API_KEY
        if not self.api_key:
            logger.warning("RAWG_API_KEY is not set. API calls will fail.")

    def search_games(self, query: SearchQuery) -> dict:
        if not self.api_key:
            raise HTTPException(status_code=400, detail="RAWG_API_KEY is not set")

        params = {"key": self.api_key, "page_size": query.page_size, "page": query.page}

        if query.query:
            params["search"] = query.query

        if query.tags:
            # RAWG expects comma-separated slugs for tags
            params["tags"] = ",".join(query.tags)

        if query.platform:
            params["platforms"] = ",".join(map(str, query.platform))

        if query.genres:
            params["genres"] = ",".join(query.genres)

        if query.ordering:
            params["ordering"] = query.ordering

        if query.search_precise:
            params["search_precise"] = query.search_precise

        if query.search_exact:
            params["search_exact"] = query.search_exact

        print(f"QUERY: {query}")

        try:
            url = f"{self.BASE_URL}/games"
            print(f"Searching RAWG with params: {params} url: {url}")

            response = requests.get(url, params=params)
            response.raise_for_status()
            data = response.json()

            results = []
            for item in data.get("results", []):
                record = self._map_to_record(item)
                results.append(record)

            next_page = None
            if data.get("next"):
                next_page = parse_qs(urlparse(data.get("next")).query).get("page")[0]
            return {"count": data.get("count"), "next": next_page, "results": results}

        except Exception as e:
            logger.error(f"RAWG Search failed: {e}")
            raise HTTPException(
                status_code=400,
                detail={"message": f"Failed to search games: {e}", "detail": str(e)},
            )

    def get_game_details(self, game_id: str) -> Optional[GameRecord]:
        if not self.api_key:
            return None

        try:
            # Main Details
            response = requests.get(
                f"{self.BASE_URL}/games/{game_id}", params={"key": self.api_key}
            )
            response.raise_for_status()
            data = response.json()
            record = self._map_to_record(data)

            # Fetch Additional Details
            # We use the 'id' or 'slug' from the data for sub-resources
            pk = str(data.get("id"))

            record.stores = self._fetch_stores(pk, record)

            return record

        except Exception as e:
            logger.error(f"RAWG Details failed for {game_id}: {e}")
            raise HTTPException(
                status_code=400,
                detail={
                    "message": f"Failed to get game details: {e}",
                    "detail": str(e),
                },
            )

    def get_game_screenshots(
        self, game_id: str, page: int = 1, page_size: int = 30
    ) -> dict:
        try:
            url = f"{self.BASE_URL}/games/{game_id}/screenshots"
            response = requests.get(
                url, params={"key": self.api_key, "page_size": page_size, "page": page}
            )
            response.raise_for_status()
            data = response.json()
            if data.get("results"):
                screenshots = [
                    Screenshot(**screenshot) for screenshot in data.get("results", [])
                ]
                next_page = None
                next = data.get("next")
                if next:
                    next_page = parse_qs(urlparse(next).query).get("page")[0]
                return {
                    "count": data.get("count"),
                    "next": next_page,
                    "results": screenshots,
                }
            else:
                return {
                    "count": 0,
                    "next": None,
                    "results": [],
                }
        except Exception as e:
            raise HTTPException(
                status_code=400,
                detail={
                    "message": f"Failed to fetch screenshots for {game_id}: {e}",
                    "detail": str(e),
                },
            )

    def get_game_trailers(
        self, game_id: str, page: int = 1, page_size: int = 30
    ) -> dict:
        return self._fetch_sub_list(
            game_id, "movies", self._map_trailer, page_size=page_size, page=page
        )

    def get_game_achievements(
        self, game_id: str, page: int = 1, page_size: int = 30
    ) -> dict:
        return self._fetch_sub_list(
            game_id,
            "achievements",
            self._map_achievement,
            page_size=page_size,
            page=page,
        )

    def get_game_reddit(self, game_id: str, page: int = 1, page_size: int = 30) -> dict:
        return self._fetch_sub_list(
            game_id, "reddit", self._map_reddit, page_size=page_size, page=page
        )

    def get_game_dlcs(self, game_id: str, page: int = 1, page_size: int = 30) -> dict:
        return self._fetch_sub_list(
            game_id, "dlcs", self._map_simple_game, page_size=page_size, page=page
        )

    def get_game_same_series(
        self, game_id: str, page: int = 1, page_size: int = 30
    ) -> dict:
        return self._fetch_sub_list(
            game_id,
            "same-series",
            self._map_simple_game,
            page_size=page_size,
            page=page,
        )

    def _fetch_sub_list(
        self,
        game_id: str,
        endpoint: str,
        mapper_func,
        record: GameRecord = None,
        page_size: int = 30,
        page: int = 1,
    ) -> List[Any]:
        try:
            url = f"{self.BASE_URL}/games/{game_id}/{endpoint}"
            response = requests.get(
                url, params={"key": self.api_key, "page_size": page_size, "page": page}
            )

            data = response.json()
            if response.status_code == 200:
                results = data.get("results", [])
                mapped = []

                if record:
                    mapped = [mapper_func(item, record) for item in results]
                else:
                    mapped = [mapper_func(item) for item in results]
                next_page = None
                next = data.get("next")
                if next:
                    next_page = parse_qs(urlparse(next).query).get("page")[0]

                return {
                    "count": data.get("count"),
                    "next": next_page,
                    "results": mapped,
                }
            else:
                raise HTTPException(status_code=response.status_code, detail=data)

        except Exception as e:
            raise HTTPException(
                status_code=400,
                detail={
                    "message": f"Failed to fetch {endpoint} for {game_id}: {e}",
                    "detail": str(e),
                },
            )

    def _fetch_stores(self, game_id: str, record: GameRecord = None) -> List[Any]:
        try:
            url = f"{self.BASE_URL}/games/{game_id}/stores"
            response = requests.get(url, params={"key": self.api_key})

            data = response.json()
            if response.status_code == 200:
                results = data.get("results", [])

                mapped = [self._map_store(item, record) for item in results]

                return mapped

            else:
                raise HTTPException(status_code=response.status_code, detail=data)

        except Exception as e:
            raise HTTPException(
                status_code=400,
                detail={
                    "message": f"Failed to fetch stores for {game_id}: {e}",
                    "detail": str(e),
                },
            )

    def _map_trailer(self, item: dict) -> dict:
        return {
            "name": item.get("name"),
            "preview": item.get("preview"),
            "video": item.get("data", {}).get("max") or item.get("data", {}).get("480"),
        }

    def _map_simple_game(self, item: dict) -> dict:
        return {
            "id": item.get("id"),
            "title": item.get("name"),
            "image": item.get("background_image"),
            "released": item.get("released"),
        }

    def _map_achievement(self, item: dict) -> dict:
        return {
            "id": item.get("id"),
            "name": item.get("name"),
            "description": item.get("description"),
            "image": item.get("image"),
        }

    def _map_reddit(self, item: dict) -> dict:
        return {
            "id": item.get("id"),
            "name": item.get("name"),
            "url": item.get("url"),
            "image": item.get("image"),
        }

    def _map_store(self, item: dict, record: GameRecord) -> Store:
        stores = record.stores
        id = item.get("store_id")
        store = [s for s in stores if s.id == id][0]
        color = storeColors.get(id)
        return Store(id=id, name=store.name, url=item.get("url"), color=color)

    def get_tags(self, query: str = None, page: int = 1, page_size: int = 20) -> dict:
        """
        Fetch tags from RAWG. Returns list of dicts (mapped to Tag model later).
        """
        if not self.api_key:
            raise HTTPException(status_code=401, detail="API key not provided")

        params = {"key": self.api_key, "page": page, "page_size": page_size}
        if query:
            params["search"] = query

        try:
            response = requests.get(f"{self.BASE_URL}/tags", params=params)
            response.raise_for_status()
            next_page = None
            next = response.json().get("next")
            if next:
                next_page = parse_qs(urlparse(next).query).get("page")[0]
            return {
                "count": response.json().get("count"),
                "next": next_page,
                "results": response.json().get("results", []),
            }
        except Exception as e:
            logger.error(f"Failed to fetch tags: {e}")
            raise HTTPException(
                status_code=400,
                detail={"message": "Failed to fetch tags", "detail": str(e)},
            )

    def _map_to_record(self, data: dict) -> GameRecord:
        raw_platforms = data.get("platforms") or []
        platforms = []
        if raw_platforms:
            for p in raw_platforms:
                platform_info = p.get("platform", {})
                requirements = p.get("requirements", {})

                platforms.append(
                    {
                        "id": platform_info.get("id"),
                        "name": platform_info.get("name"),
                        "requirements": requirements if requirements else None,
                        "released": p.get("released_at"),
                        "color": platformColors.get(platform_info.get("id")),
                    }
                )

        stores: List[Store] = []
        if data.get("stores"):
            for s in data.get("stores"):
                store_info = s.get("store", {})
                url = s.get("url_en") or s.get("url")  # RAWG stricture varies
                if not url and store_info.get("domain"):
                    url = f"https://{store_info.get('domain')}"

                if store_info.get("name"):
                    stores.append(
                        {
                            "id": store_info.get("id"),
                            "name": store_info.get("name"),
                            "url": url or "",  # Might be empty in search list
                            "image_background": store_info.get("image_background"),
                        }
                    )

        return GameRecord(
            id=str(data.get("id")),
            title=data.get("name") or "Unknown Title",
            platforms=platforms,
            release_date=data.get("released"),
            image_url=data.get("background_image"),
            score=data.get("rating"),
            website=data.get("website"),
            stores=stores,
            esrb_rating=data.get("esrb_rating"),
            extra={
                "slug": data.get("slug"),
                "metacritic": data.get("metacritic"),
                "description_raw": data.get("description_raw"),  # Useful for details
            },
        )
