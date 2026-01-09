"""GameHunter Engine - RAWG API Client.

This module provides a client for interacting with the RAWG.io Video Games Database API.
It handles game search, detailed game information retrieval, and fetching related content
like screenshots, trailers, achievements, and community data.

The client automatically maps RAWG's API responses to our standardized GameRecord models
and handles pagination, error handling, and color/icon assignment for stores and platforms.

See: https://api.rawg.io/docs/
"""

import logging
import time
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

logger = logging.getLogger("RAWG")


class RawgClient:
    """Client for the RAWG.io Video Games Database API.

    Provides methods for searching games, retrieving detailed game information,
    and fetching related content like media, DLCs, achievements, and community posts.

    Attributes:
        BASE_URL: RAWG API base URL.
        api_key: API key for authentication.
    """

    BASE_URL = "https://api.rawg.io/api"

    def __init__(self, api_key: str = None):
        """Initialize the RAWG API client.

        Args:
            api_key: Optional API key. If not provided, uses RAWG_API_KEY from settings.
        """
        self.api_key = api_key or settings.RAWG_API_KEY
        if not self.api_key:
            logger.warning("RAWG_API_KEY is not set. API calls will fail.")

    def search_games(self, query: SearchQuery) -> dict:
        """Search for games with filters and pagination.

        Queries the RAWG API with search parameters and returns paginated results.

        Args:
            query: SearchQuery object with search parameters.

        Returns:
            dict: Search results with 'count', 'next' page number, and 'results' list.

        Raises:
            HTTPException: If API key is missing or search fails.
        """
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

        logger.info(f"QUERY: {query}")

        try:
            url = f"{self.BASE_URL}/games"
            logger.info(f"Searching RAWG with params: {params} url: {url}")

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
        """Get detailed information about a specific game.

        Fetches comprehensive game data including platforms, requirements, stores,
        and metadata.

        Args:
            game_id: RAWG game ID or slug.

        Returns:
            GameRecord: Complete game information, or None if API key is missing.

        Raises:
            HTTPException: If retrieval fails.
        """
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
        """Get paginated screenshots for a game.

        Args:
            game_id: RAWG game ID.
            page: Page number for pagination.
            page_size: Number of screenshots per page.

        Returns:
            dict: Screenshot data with pagination info.

        Raises:
            HTTPException: If fetch fails.
        """
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
        """Get paginated video trailers for a game.

        Args:
            game_id: RAWG game ID.
            page: Page number for pagination.
            page_size: Number of trailers per page.

        Returns:
            dict: Trailer data with pagination info.
        """
        return self._fetch_sub_list(
            game_id, "movies", self._map_trailer, page_size=page_size, page=page
        )

    def get_game_achievements(
        self, game_id: str, page: int = 1, page_size: int = 30
    ) -> dict:
        """Get paginated achievements for a game.

        Args:
            game_id: RAWG game ID.
            page: Page number for pagination.
            page_size: Number of achievements per page.

        Returns:
            dict: Achievement data with pagination info.
        """
        return self._fetch_sub_list(
            game_id,
            "achievements",
            self._map_achievement,
            page_size=page_size,
            page=page,
        )

    def get_game_reddit(self, game_id: str, page: int = 1, page_size: int = 30) -> dict:
        """Get paginated Reddit posts about a game.

        Args:
            game_id: RAWG game ID.
            page: Page number for pagination.
            page_size: Number of posts per page.

        Returns:
            dict: Reddit post data with pagination info.
        """
        return self._fetch_sub_list(
            game_id, "reddit", self._map_reddit, page_size=page_size, page=page
        )

    def get_game_dlcs(self, game_id: str, page: int = 1, page_size: int = 30) -> dict:
        """Get paginated DLCs and editions for a game.

        Args:
            game_id: RAWG game ID.
            page: Page number for pagination.
            page_size: Number of DLCs per page.

        Returns:
            dict: DLC data with pagination info.
        """
        return self._fetch_sub_list(
            game_id, "dlcs", self._map_simple_game, page_size=page_size, page=page
        )

    def get_game_same_series(
        self, game_id: str, page: int = 1, page_size: int = 30
    ) -> dict:
        """Get paginated games in the same series.

        Args:
            game_id: RAWG game ID.
            page: Page number for pagination.
            page_size: Number of games per page.

        Returns:
            dict: Game data for series entries with pagination info.
        """
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
        """Internal helper for fetching paginated sub-resources.

        Args:
            game_id: RAWG game ID.
            endpoint: API endpoint name (e.g., 'movies', 'achievements').
            mapper_func: Function to map each result item.
            record: Optional GameRecord for context.
            page_size: Number of results per page.
            page: Page number.

        Returns:
            dict: Mapped results with pagination info.

        Raises:
            HTTPException: If fetch fails.
        """
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
        """Fetch store information for a game.

        Args:
            game_id: RAWG game ID.
            record: GameRecord for store icon/color mapping.

        Returns:
            list: List of Store objects with URLs and branding.

        Raises:
            HTTPException: If fetch fails.
        """
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
        """Map RAWG trailer data to standard format.

        Args:
            item: Raw trailer data from RAWG.

        Returns:
            dict: Mapped trailer with name, preview, and video URL.
        """
        return {
            "name": item.get("name"),
            "preview": item.get("preview"),
            "video": item.get("data", {}).get("max") or item.get("data", {}).get("480"),
        }

    def _map_simple_game(self, item: dict) -> dict:
        """Map RAWG game data to simplified format.

        Args:
            item: Raw game data from RAWG.

        Returns:
            dict: Simplified game data with id, title, image, and release date.
        """
        return {
            "id": item.get("id"),
            "title": item.get("name"),
            "image": item.get("background_image"),
            "released": item.get("released"),
        }

    def _map_achievement(self, item: dict) -> dict:
        """Map RAWG achievement data to standard format.

        Args:
            item: Raw achievement data from RAWG.

        Returns:
            dict: Mapped achievement with id, name, description, and image.
        """
        return {
            "id": item.get("id"),
            "name": item.get("name"),
            "description": item.get("description"),
            "image": item.get("image"),
        }

    def _map_reddit(self, item: dict) -> dict:
        """Map RAWG Reddit post data to standard format.

        Args:
            item: Raw Reddit post data from RAWG.

        Returns:
            dict: Mapped Reddit post with id, name, URL, and image.
        """
        return {
            "id": item.get("id"),
            "name": item.get("name"),
            "url": item.get("url"),
            "image": item.get("image"),
        }

    def _map_store(self, item: dict, record: GameRecord) -> Store:
        """Map RAWG store data to Store model with branding colors.

        Args:
            item: Raw store data from RAWG.
            record: GameRecord to extract store name.

        Returns:
            Store: Store object with URL and brand color.
        """
        stores = record.stores
        id = item.get("store_id")
        store = [s for s in stores if s.id == id][0]
        color = storeColors.get(id)
        return Store(id=id, name=store.name, url=item.get("url"), color=color)

    def get_tags(self, query: str = None, page: int = 1, page_size: int = 20) -> dict:
        """Search and retrieve game tags.

        Fetches available tags used to categorize games on RAWG.

        Args:
            query: Optional search query to filter tags.
            page: Page number for pagination.
            page_size: Number of tags per page.

        Returns:
            dict: Tags with 'count', 'next' page, and 'results' list.

        Raises:
            HTTPException: If API key is missing or fetch fails.
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
        """Convert RAWG API response to GameRecord model.

        Maps raw RAWG game data to our standardized GameRecord format,
        including platforms with requirements, stores with branding,
        and additional metadata.

        Args:
            data: Raw game data from RAWG API.

        Returns:
            GameRecord: Standardized game record.
        """
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

    def get_tags_until_end(self, query: str = None) -> list[dict]:
        """Fetch all tags by paginating until there are no more pages.

        Args:
            query: Optional search query to filter tags.

        Returns:
            dict: All tags with 'count' and 'results' list.

        Raises:
            HTTPException: If API key is missing or fetch fails.
        """
        if not self.api_key:
            raise HTTPException(status_code=401, detail="API key not provided")
        page_limit = 4
        all_tags = []
        page = 1
        params = {"key": self.api_key, "page_size": 40}
        if query:
            params["search"] = query

        try:
            logger.info(f"Starting tag fetch with query: '{query or 'all'}'")

            while True:
                params["page"] = page
                logger.debug(f"Fetching tags page {page}...")

                response = requests.get(f"{self.BASE_URL}/tags", params=params)
                response.raise_for_status()
                data = response.json()

                results = data.get("results", [])
                logger.info(f"Page {page}: Retrieved {len(results)} tags")

                # Filter to only include required fields
                filtered_results = [
                    {
                        "name": tag.get("name"),
                        "slug": tag.get("slug"),
                        "games_count": tag.get("games_count"),
                        "score": tag.get("score"),
                    }
                    for tag in results
                ]
                all_tags.extend(filtered_results)
                # Check if there's a next page
                if data.get("next") is None or page >= page_limit:
                    if page > page_limit:
                        logger.warning(
                            f"Stopping tag fetch: page limit ({page_limit}) reached"
                        )
                    else:
                        logger.info("Stopping tag fetch: no more pages available")
                    break

                page += 1
                logger.debug("Waiting 1 second before next request...")
                time.sleep(1)  # Small delay to avoid rate limiting

            logger.info(f"Tag fetch complete. Total tags retrieved: {len(all_tags)}")
            return all_tags
        except Exception as e:
            logger.error(f"Failed to fetch tags: {e}")
            raise HTTPException(
                status_code=400,
                detail={"message": "Failed to fetch tags", "detail": str(e)},
            )
