from pydantic import BaseModel, Field
from typing import List, Optional, Dict, Any

class GameRecord(BaseModel):
    """
    Standardized Game Record from an API.
    """
    id: str = Field(..., description="Unique ID from the source (e.g., 'rawg-123')")
    source: str = Field(..., description="Source name (rawg, igdb)")
    title: str
    platforms: List[str] = Field(default_factory=list)
    release_date: Optional[str] = None
    description: Optional[str] = None
    image_url: Optional[str] = None
    score: Optional[float] = None
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
