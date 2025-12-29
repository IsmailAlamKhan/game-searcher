from pydantic import BaseModel, Field
from typing import List, Optional, Dict, Any

class Screenshot(BaseModel):
    id: int
    image: str
    width: Optional[int] = None
    height: Optional[int] = None
    is_deleted: Optional[bool] = None



class Store(BaseModel):
    id: int
    name: str
    url: str
    color: Optional[str] = None
    icon: Optional[str] = None


class Requirements(BaseModel):
    minimum: Optional[str] = None
    recommended: Optional[str] = None

class Platform(BaseModel):
    id: int
    name: str
    requirements: Optional[Requirements] = None
    released: Optional[str] = None
    color: Optional[str] = None
    icon: Optional[str] = None


class GameRecord(BaseModel):
    """
    Standardized Game Record from an API.
    """
    id: str = Field(..., description="Unique ID from the source (e.g., 'rawg-123')")
    source: str = Field(..., description="Source name (rawg, igdb)")
    title: str
    platforms: List[Platform] = Field(default_factory=list)
    release_date: Optional[str] = None
    description: Optional[str] = None
    image_url: Optional[str] = None
    score: Optional[float] = None
    stores: List[Store] = Field(default_factory=list, description="List of stores with 'name' and 'url'")
    website: Optional[str] = None
    
    # Detailed Info (usually populated only for single game retrieval)
    screenshots: List[str] = Field(default_factory=list)
    trailers: List[Dict[str, str]] = Field(default_factory=list, description="List of trailers with 'name', 'preview', 'data'")
    dlcs: List[Dict[str, Any]] = Field(default_factory=list, description="Downloadable content and editions")
    same_series: List[Dict[str, Any]] = Field(default_factory=list, description="Games in the same series")
    achievements: List[Dict[str, Any]] = Field(default_factory=list)
    reddit_posts: List[Dict[str, Any]] = Field(default_factory=list)
    
    extra: Dict[str, Any] = Field(default_factory=dict)

class Tag(BaseModel):
    """
    Tag from the API.
    """
    id: int
    name: str
    slug: str
    games_count: int
    image_background: Optional[str] = None

class SearchQuery(BaseModel):
    """
    Standard search parameters.
    """
    query: Optional[str] = None
    tags: Optional[List[str]] = None
    platforms: Optional[List[str]] = None
    page_size: int = 20
    page: int = 1

class SearchPreset(BaseModel):
    """
    Saved Search Configuration.
    """
    id: str
    name: str
    description: Optional[str] = None
    query: SearchQuery


storeColors: dict[int, str] = {
    # Steam
    1: '66C0F4',
    # Xbox Store
    2: '107C10',
    # PlayStation Store
    3: '0070D1',
    # Epic Games Store
    11: 'ffffff',
    # GOG.com
    5: '86328A',
    # itch.io
    9: 'FA5C5C',
    # Google Play
    8: '34A853',
    # Apple / App Store / Sign in with Apple
    4: 'A3AAAE',
    # XBox 360 store
    7: '92C83E',
}

platformColors: dict[int, str] = {
    # PC
    4: '0078D6',
    # iOS
    3: '0484EB',
    # Android
    21: 'A4C639',
    # Xbox
    186: '107C10',
    # Xbox 360
    14: '92C83E',
    # Xbox One
    1: '107C10',
    # PlayStation 5
    187: '006FCD',
    # PlayStation 4
    18: '006FCD',
    # PlayStation 3
    16: '000000',
    # PlayStation 2
    15: '000000',
    # macOS
    5: 'A3AAAE',
    # Linux
    6: 'FDD835',
    # Nintendo
    7: 'E60012',
}