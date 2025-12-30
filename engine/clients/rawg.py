import requests
from typing import List, Optional, Any
import logging
from urllib.parse import urlparse, parse_qs
from .base import GameApiClient
from core.models import GameRecord, SearchQuery, Screenshot
from core.config import settings
from core.models import storeColors, Store, platformColors
from fastapi import HTTPException



logger = logging.getLogger()


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
            "page_size": query.page_size,
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

            record.stores = self._fetch_sub_list(pk, "stores", self._map_store, record)
          
            return record
            
        except Exception as e:
            logger.error(f"RAWG Details failed for {game_id}: {e}")
            return None
      
    def get_game_screenshots(self, game_id: str, page: int = 1, page_size: int = 30) -> dict:
        try:
            url = f"{self.BASE_URL}/games/{game_id}/screenshots"
            response = requests.get(url, params={"key": self.api_key, "page_size": page_size, "page": page})
            response.raise_for_status()
            data = response.json()
            if data.get("results"):
                screenshots = [Screenshot(**screenshot) for screenshot in data.get("results", [])]
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
            raise HTTPException(status_code=400, detail={
                "message": f"Failed to fetch screenshots for {game_id}: {e}",
                "detail": str(e)
            })

    def get_game_trailers(self, game_id: str, page: int = 1, page_size: int = 30) -> dict:
        return self._fetch_sub_list(game_id, "movies", self._map_trailer, page_size=page_size, page=page)
    
    def get_game_achievements(self, game_id: str, page: int = 1, page_size: int = 30) -> dict:
        return self._fetch_sub_list(game_id, "achievements", self._map_achievement, page_size=page_size, page=page)
    
    def get_game_reddit(self, game_id: str, page: int = 1, page_size: int = 30) -> dict:
        return self._fetch_sub_list(game_id, "reddit", self._map_reddit, page_size=page_size, page=page)

    def get_game_dlcs(self, game_id: str, page: int = 1, page_size: int = 30) -> dict:
        return self._fetch_sub_list(game_id, "dlcs", self._map_simple_game, page_size=page_size, page=page)
    
    def get_game_same_series(self, game_id: str, page: int = 1, page_size: int = 30) -> dict:
        return self._fetch_sub_list(game_id, "same-series", self._map_simple_game, page_size=page_size, page=page)
   
    

    def _fetch_sub_list(self, game_id: str, endpoint: str, mapper_func, record: GameRecord = None, page_size: int = 30, page: int = 1) -> List[Any]:
        try:
            url = f"{self.BASE_URL}/games/{game_id}/{endpoint}"
            response = requests.get(url, params={"key": self.api_key, "page_size": page_size, "page": page})

            data = response.json()
            if response.status_code == 200:
                results = data.get("results", [])
                mapped = []

                if (record):
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
                    "results": mapped
                }
            else:
                raise HTTPException(status_code=response.status_code, detail=data)
                
        except Exception as e:
            raise HTTPException(status_code=400, detail={
                "message": f"Failed to fetch {endpoint} for {game_id}: {e}",
                "detail": str(e)
            })


    def _map_trailer(self, item: dict) -> dict:
        return {
            "name": item.get("name"),
            "preview": item.get("preview"),
            "video": item.get("data", {}).get("max") or item.get("data", {}).get("480")
        }

    def _map_simple_game(self, item: dict) -> dict:
        return {
            "id": item.get("id"),
            "title": item.get("name"),
            "image": item.get("background_image"),
            "released": item.get("released")
        }
    
    def _map_achievement(self, item: dict) -> dict:
        return {
            "id": item.get("id"),
            "name": item.get("name"),
            "description": item.get("description"),
            "image": item.get("image")
        }

    def _map_reddit(self, item: dict) -> dict:
        return {
            "id": item.get("id"),
            "name": item.get("name"),
            "url": item.get("url"),
            "image": item.get("image")
        }

    def _map_store(self, item: dict, record: GameRecord) -> Store:
        stores = record.stores
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
