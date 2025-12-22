from abc import ABC, abstractmethod
from typing import List, Optional
from core.models import GameRecord, SearchQuery

class GameApiClient(ABC):
    """
    Abstract base class for Game API clients.
    """
    
    @abstractmethod
    def search_games(self, query: SearchQuery) -> List[GameRecord]:
        """
        Search for games based on the query.
        """
        pass
    
    @abstractmethod
    def get_game_details(self, game_id: str) -> Optional[GameRecord]:
        """
        Get detailed information for a specific game.
        """
        pass
