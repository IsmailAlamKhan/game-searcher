import requests
from typing import List, Optional, Any
import logging
from .base import GameApiClient
from core.models import GameRecord, SearchQuery
from core.config import settings
from core.models import storeColors, Store, platformColors

logger = logging.getLogger(__name__)

class RawgClient(GameApiClient):
    BASE_URL = "https://api.rawg.io/api"
    
    def __init__(self, api_key: str = None):
        self.api_key = api_key or settings.RAWG_API_KEY
        if not self.api_key:
            logger.warning("RAWG_API_KEY is not set. API calls will fail.")

    def search_games(self, query: SearchQuery) -> List[GameRecord]:
        if not self.api_key:
            return []
            
        params = {
            "key": self.api_key,
            "page_size": query.limit,
            "page": query.page
        }

        print(f"QUERY: {query}")
        
        if query.query:
            params["search"] = query.query
            
        if query.tags:
            # RAWG expects comma-separated slugs for tags
            params["tags"] = ",".join(query.tags)
            
        # Add platform filtering if needed (RAWG uses platform IDs, would need mapping)
        
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
                
            return results
            
        except Exception as e:
            logger.error(f"RAWG Search failed: {e}")
            return []

    def get_game_details(self, game_id: str) -> Optional[GameRecord]:
        if not self.api_key:
            return None
            
        try:
            # Main Details
            response = requests.get(f"{self.BASE_URL}/games/{game_id}", params={"key": self.api_key})
            response.raise_for_status()
            data = response.json()
            record = self._map_to_record(data)
            
            # Fetch Additional Details
            # We use the 'id' or 'slug' from the data for sub-resources
            pk = str(data.get('id')) 
            
            # 1. Screenshots
            record.screenshots = self._fetch_sub_images(pk, "screenshots", "image")
            
            # 2. Trailers (Movies)
            record.trailers = self._fetch_sub_list(pk, "movies", self._map_trailer, record)
            
            # 3. DLCs (Additions)
            record.dlcs = self._fetch_sub_list(pk, "additions", self._map_simple_game, record)
            
            # 4. Series
            record.same_series = self._fetch_sub_list(pk, "game-series", self._map_simple_game, record)
            
            # # 5. Achievements
            # record.achievements = self._fetch_sub_list(pk, "achievements", self._map_achievement, record, limit=200)

            # 6. Reddit
            record.reddit_posts = self._fetch_sub_list(pk, "reddit", self._map_reddit, record)
            
            # Stores
            record.stores = self._fetch_sub_list(pk, "stores", self._map_store, record)

            return record
            
        except Exception as e:
            logger.error(f"RAWG Details failed for {game_id}: {e}")
            return None

    def _fetch_sub_list(self, game_id: str, endpoint: str, mapper_func,record: GameRecord , limit: int = 30) -> List[Any]:
        try:
            url = f"{self.BASE_URL}/games/{game_id}/{endpoint}"
            response = requests.get(url, params={"key": self.api_key, "page_size": limit})
            if response.status_code == 200:
                results = response.json().get("results", [])
                mapped = [mapper_func(item, record) for item in results]
                return mapped
        except Exception as e:
            logger.warning(f"Failed to fetch {endpoint} for {game_id}: {e}")
        return []

    def _fetch_sub_images(self, game_id: str, endpoint: str, key: str) -> List[str]:
        try:
            url = f"{self.BASE_URL}/games/{game_id}/{endpoint}"
            response = requests.get(url, params={"key": self.api_key})
            if response.status_code == 200:
                results = response.json().get("results", [])
                return [item.get(key) for item in results if item.get(key)]
        except Exception:
            pass
        return []

    def _map_trailer(self, item: dict, record: GameRecord) -> dict:
        return {
            "name": item.get("name"),
            "preview": item.get("preview"),
            "video": item.get("data", {}).get("max") or item.get("data", {}).get("480")
        }

    def _map_simple_game(self, item: dict, record: GameRecord) -> dict:
        return {
            "id": item.get("id"),
            "title": item.get("name"),
            "image": item.get("background_image"),
            "released": item.get("released")
        }
    
    def _map_achievement(self, item: dict, record: GameRecord) -> dict:
        return {
            "id": item.get("id"),
            "name": item.get("name"),
            "description": item.get("description"),
            "image": item.get("image")
        }

    def _map_reddit(self, item: dict, record: GameRecord) -> dict:
        return {
            "id": item.get("id"),
            "name": item.get("name"),
            "url": item.get("url"),
            "image": item.get("image")
        }

    def _map_store(self, item: dict, record: GameRecord) -> Store:
        stores = record.stores
        logger.info(f"Stores: {stores}")
        id = item.get("store_id")
        store = [s for s in stores if s.id == id][0]
        color = storeColors.get(id)
        return Store(
            id=id,
            name=store.name,
            url=item.get("url"),
            color=color
        )

    def get_tags(self, query: str = None, page: int = 1, page_size: int = 20) -> List[dict]:
        """
        Fetch tags from RAWG. Returns list of dicts (mapped to Tag model later).
        """
        if not self.api_key:
            return []
            
        params = {
            "key": self.api_key,
            "page": page,
            "page_size": page_size
        }
        if query:
            params["search"] = query
            
        try:
            response = requests.get(f"{self.BASE_URL}/tags", params=params)
            response.raise_for_status()
            return response.json().get("results", [])
        except Exception as e:
            logger.error(f"RAWG Tag Search failed: {e}")
            return []
            

    def _map_to_record(self, data: dict) -> GameRecord:
        raw_platforms = data.get('platforms') or [] 
        platforms = []
        if raw_platforms:
             for p in raw_platforms:
                platform_info = p.get('platform', {})
                requirements = p.get('requirements', {})

                platforms.append({
                    "id": platform_info.get('id'),
                    "name": platform_info.get('name'),
                    "requirements": requirements if requirements else None,
                    "released": p.get('released_at'),
                    "color": platformColors.get(platform_info.get('id'))
                })                 
        
        stores: List[Store] = []
        if data.get('stores'):
            for s in data.get('stores'):
                store_info = s.get('store', {})
                url = s.get('url_en') or s.get('url') # RAWG stricture varies
                if not url and store_info.get('domain'):
                     url = f"https://{store_info.get('domain')}"
                
                if store_info.get('name'):
                    stores.append({
                        "id": store_info.get('id'),
                        "name": store_info.get('name'),
                        "url": url or "", # Might be empty in search list
                        "image_background": store_info.get('image_background')
                    })
        
        return GameRecord(
            id=str(data.get('id')),
            source="rawg",
            title=data.get('name') or "Unknown Title",
            platforms=platforms,
            release_date=data.get('released'),
            image_url=data.get('background_image'),
            score=data.get('rating'),
            website=data.get('website'),
            stores=stores,
            extra={
                "slug": data.get('slug'),
                "metacritic": data.get('metacritic'),
                "description_raw": data.get('description_raw') # Useful for details
            }
        )
