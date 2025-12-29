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

    @abstractmethod
    def get_game_screenshots(self, game_id: str, page: int = 1, page_size: int = 20) -> dict:
        """
        Get screenshots for a specific game.
        """
        pass
    
    @abstractmethod
    def get_game_trailers(self, game_id: str, page: int = 1, page_size: int = 30) -> dict:
        """
        Get trailers for a specific game.
        """
        pass
    
    @abstractmethod
    def get_game_achievements(self, game_id: str, page: int = 1, page_size: int = 30) -> dict:
        """
        Get achievements for a specific game.
        """
        pass
    
    @abstractmethod
    def get_game_reddit(self, game_id: str, page: int = 1, page_size: int = 30) -> dict:
        """
        Get Reddit posts for a specific game.
        """
        pass
    
    @abstractmethod
    def get_game_dlcs(self, game_id: str, page: int = 1, page_size: int = 30) -> dict:
        """
        Get DLCs for a specific game.
        """
        pass

    @abstractmethod
    def get_game_same_series(self, game_id: str, page: int = 1, page_size: int = 30) -> dict:
        """
        Get same series for a specific game.
        """
        pass
