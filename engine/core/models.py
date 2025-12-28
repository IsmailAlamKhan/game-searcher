from pydantic import BaseModel, Field
from typing import List, Optional, Dict, Any

class Store(BaseModel):
    id: int
    name: str
    url: str
    image_background: Optional[str] = None


class Requirements(BaseModel):
    minimum: Optional[str] = None
    recommended: Optional[str] = None

class Platform(BaseModel):
    id: int
    name: str
    requirements: Optional[Requirements] = None
    released: Optional[str] = None


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
    limit: int = 20

class SearchPreset(BaseModel):
    """
    Saved Search Configuration.
    """
    id: str
    name: str
    description: Optional[str] = None
    query: SearchQuery
