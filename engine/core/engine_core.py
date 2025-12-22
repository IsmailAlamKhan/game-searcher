import logging
from typing import List, Dict, Type, Optional
from .models import GameRecord, SearchQuery
from clients.base import GameApiClient
from clients.rawg import RawgClient

logger = logging.getLogger(__name__)

class GameSearchEngine:
    def __init__(self):
        self.clients: Dict[str, GameApiClient] = {}
        
        # Initialize clients
        try:
            self.clients["rawg"] = RawgClient()
        except Exception as e:
            logger.error(f"Failed to initialize RawgClient: {e}")

    def search(self, query: SearchQuery) -> List[GameRecord]:
        """
        Search across all configured clients and aggregate results.
        For now, just using RAWG.
        """
        all_results = []
        
        for name, client in self.clients.items():
            try:
                if query.query:
                    logger.info(f"Searching {name} for '{query.query}'...")
                elif query.tags:
                    logger.info(f"Searching {name} for tags: {query.tags}...")
                else:
                    logger.info(f"Searching {name} (no query)...")
                results = client.search_games(query)
                all_results.extend(results)
            except Exception as e:
                logger.error(f"Search failed for {name}: {e}")
                
        return self._deduplicate(all_results)

    def get_game_details(self, game_id: str, source: str) -> Optional[GameRecord]:
        client = self.clients.get(source)
        if not client:
            logger.error(f"Source {source} not found.")
            return None
            
        return client.get_game_details(game_id)

    def get_tags(self, query: str = None, page: int = 1, page_size: int = 20) -> List[dict]:
        """
        Get tags from primary client (RAWG).
        """
        # Assuming RAWG is primary for tags
        client = self.clients.get("rawg")
        if not client:
            return []
        
        # We could map this to Tag model here or in client
        # For now return raw dicts or map to Tag
        from .models import Tag
        
        raw_tags = client.get_tags(query, page, page_size)
        tags = []
        for t in raw_tags:
            tags.append(Tag(
                id=t.get('id'),
                name=t.get('name'),
                slug=t.get('slug'),
                games_count=t.get('games_count'),
                image_background=t.get('image_background')
            ))
        return tags

    def _deduplicate(self, games: List[GameRecord]) -> List[GameRecord]:
        """
        Simple deduplication by Title for now.
        APIs might return slightly different titles, so fuzzy match might be needed later.
        """
        seen = set()
        unique_games = []
        
        for game in games:
            # Normalized key
            key = game.title.lower().strip()
            if key not in seen:
                seen.add(key)
                unique_games.append(game)
                
        return unique_games
