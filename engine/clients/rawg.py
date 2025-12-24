import requests
from typing import List, Optional
import logging
from .base import GameApiClient
from core.models import GameRecord, SearchQuery
from core.config import settings

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
        }

        logger.info(f"QUERY: {query}")
        
        if query.query:
            params["search"] = query.query
            
        if query.tags:
            # RAWG expects comma-separated slugs for tags
            params["tags"] = ",".join(query.tags)
            
        # Add platform filtering if needed (RAWG uses platform IDs, would need mapping)
        
        try:
            logger.info(f"Searching RAWG with params: {params}")
            response = requests.get(f"{self.BASE_URL}/games", params=params)
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
            # RAWG IDs are usually numeric but the API accepts slug too? 
            # The GameRecord ID from search result is used here.
            response = requests.get(f"{self.BASE_URL}/games/{game_id}", params={"key": self.api_key})
            response.raise_for_status()
            data = response.json()
            return self._map_to_record(data)
            
        except Exception as e:
            logger.error(f"RAWG Details failed for {game_id}: {e}")
            return None

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
        # data.get('platforms') can be None if empty in some responses? 
        # or structure is [{'platform': {'name': ...}}]
        raw_platforms = data.get('platforms') or [] 
        platforms = []
        if raw_platforms:
             platforms = [p['platform']['name'] for p in raw_platforms if p.get('platform')]
        
        return GameRecord(
            id=str(data.get('id')),
            source="rawg",
            title=data.get('name') or "Unknown Title",
            platforms=platforms,
            release_date=data.get('released'),
            image_url=data.get('background_image'),
            score=data.get('rating'),
            extra={
                "slug": data.get('slug'),
                "metacritic": data.get('metacritic')
            }
        )
