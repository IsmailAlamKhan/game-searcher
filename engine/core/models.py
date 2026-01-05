"""GameHunter Engine - Data Models.

This module defines Pydantic models used throughout the GameHunter Engine application.
All models provide JSON serialization/deserialization and validation for API requests and responses.

Models:
    Screenshot: Game screenshot metadata
    Store: Store information (Steam, Epic, etc.)
    Requirements: PC system requirements
    Platform: Platform-specific game information
    GameRecord: Complete game information
    Tag: Game tag/category
    SearchQuery: Game search parameters
    SearchPreset: Saved search configuration
"""

from typing import Any, Dict, List, Optional

from pydantic import BaseModel, Field


class Screenshot(BaseModel):
    """Game screenshot metadata.

    Represents a screenshot from a game with its URL and dimensions.

    Attributes:
        id: Unique screenshot identifier.
        image: URL to the screenshot image.
        width: Image width in pixels, if available.
        height: Image height in pixels, if available.
        is_deleted: Whether the screenshot has been deleted.
    """

    id: int
    image: str
    width: Optional[int] = None
    height: Optional[int] = None
    is_deleted: Optional[bool] = None


class Store(BaseModel):
    """Game store information.

    Represents a digital store where a game can be purchased (Steam, Epic Games, etc.).

    Attributes:
        id: Unique store identifier.
        name: Store name (e.g., 'Steam', 'Epic Games Store').
        url: URL to the game's store page.
        color: Brand color hex code for UI theming.
        icon: URL to store icon/logo.
    """

    id: int
    name: str
    url: str
    color: Optional[str] = None
    icon: Optional[str] = None


class Requirements(BaseModel):
    """PC system requirements.

    Stores minimum and recommended PC specifications for running a game.
    Requirements are stored as raw text from the API.

    Attributes:
        minimum: Minimum system requirements text.
        recommended: Recommended system requirements text.
    """

    minimum: Optional[str] = None
    recommended: Optional[str] = None


class Platform(BaseModel):
    """Platform-specific game information.

    Represents a gaming platform (PC, PlayStation, Xbox, etc.) and platform-specific
    details like system requirements and release dates.

    Attributes:
        id: Unique platform identifier.
        name: Platform name (e.g., 'PC', 'PlayStation 5').
        requirements: System requirements for this platform (PC only).
        released: Release date for this platform.
        color: Brand color hex code for UI theming.
        icon: URL to platform icon/logo.
    """

    id: int
    name: str
    requirements: Optional[Requirements] = None
    released: Optional[str] = None
    color: Optional[str] = None
    icon: Optional[str] = None


class GameRecord(BaseModel):
    """Complete game information record.

    Standardized representation of a game from the RAWG API, containing all available
    game metadata including platforms, stores, media, and community content.

    Attributes:
        id: Unique game identifier from the source API.
        title: Game title.
        platforms: List of platforms the game is available on.
        release_date: Game release date (ISO format).
        description: Detailed game description (may contain HTML).
        image_url: URL to the game's cover/header image.
        score: Aggregate rating score.
        stores: List of stores where the game can be purchased.
        website: Official game website URL.
        screenshots: List of screenshot URLs (populated for detail views).
        trailers: List of video trailers (populated for detail views).
        dlcs: Downloadable content and editions (populated for detail views).
        same_series: Related games in the same series (populated for detail views).
        achievements: Game achievements (populated for detail views).
        reddit_posts: Related Reddit posts (populated for detail views).
        esrb_rating: ESRB rating information.
        extra: Additional metadata not covered by standard fields.
    """

    id: str = Field(..., description="Unique ID from the source (e.g., 'rawg-123')")
    title: str
    platforms: List[Platform] = Field(default_factory=list)
    release_date: Optional[str] = None
    description: Optional[str] = None
    image_url: Optional[str] = None
    score: Optional[float] = None
    stores: List[Store] = Field(
        default_factory=list, description="List of stores with 'name' and 'url'"
    )
    website: Optional[str] = None

    # Detailed Info (usually populated only for single game retrieval)
    screenshots: List[str] = Field(default_factory=list)
    trailers: List[Dict[str, str]] = Field(
        default_factory=list,
        description="List of trailers with 'name', 'preview', 'data'",
    )
    dlcs: List[Dict[str, Any]] = Field(
        default_factory=list, description="Downloadable content and editions"
    )
    same_series: List[Dict[str, Any]] = Field(
        default_factory=list, description="Games in the same series"
    )
    achievements: List[Dict[str, Any]] = Field(default_factory=list)
    reddit_posts: List[Dict[str, Any]] = Field(default_factory=list)
    esrb_rating: Optional[Dict[str, Any]] = None
    extra: Dict[str, Any] = Field(default_factory=dict)


class Tag(BaseModel):
    """Game tag/category.

    Represents a taxonomic tag used to categorize games (e.g., 'Multiplayer', 'RPG', 'Indie').

    Attributes:
        id: Unique tag identifier.
        name: Human-readable tag name.
        slug: URL-friendly tag identifier.
        games_count: Number of games with this tag.
        image_background: Background image URL for the tag.
    """

    id: int
    name: str
    slug: str
    games_count: int
    image_background: Optional[str] = None


class SearchQuery(BaseModel):
    """Game search query parameters.

    Encapsulates all parameters for searching and filtering games.
    Supports full-text search, filtering by multiple criteria, and pagination.

    Attributes:
        query: Search query string for full-text search.
        search_precise: Enable precise matching of search terms.
        search_exact: Require exact matches for search terms.
        ordering: Field to order results by (prefix with '-' for descending).
            Options: 'name', 'released', 'added', 'created', 'updated', 'rating', 'metacritic'.
        platform: Filter by platform IDs.
        genres: Filter by genre slugs.
        tags: Filter by tag slugs or IDs.
        page_size: Number of results per page (default: 20).
        page: Page number for pagination (default: 1).
    """

    query: Optional[str] = None
    search_precise: Optional[bool] = None
    search_exact: Optional[bool] = None
    # name, released, added, created, updated, rating, metacritic
    ordering: Optional[str] = None
    platform: Optional[List[int]] = None
    genres: Optional[List[str]] = None
    tags: Optional[List[str]] = None
    page_size: int = 20
    page: int = 1


class SearchPreset(BaseModel):
    """Saved search configuration.

    Allows users to save and reuse complex search queries.

    Attributes:
        id: Unique preset identifier.
        name: User-friendly preset name.
        description: Optional description of what this preset searches for.
        query: The search query parameters.
    """

    id: str
    name: str
    description: Optional[str] = None
    query: SearchQuery


# --- Response Models ---


class PaginatedResponse(BaseModel):
    """Generic paginated response wrapper.

    Wraps paginated results with count and next page information.

    Attributes:
        count: Total number of items available.
        next: Next page number, or None if this is the last page.
        results: List of result items (type varies by endpoint).
    """

    count: int
    next: Optional[int] = None
    results: List[Any]


class TrailerResponse(BaseModel):
    """Video trailer information.

    Attributes:
        name: Trailer name/title.
        preview: URL to preview image/thumbnail.
        video: URL to the video file.
    """

    name: str
    preview: Optional[str] = None
    video: Optional[str] = None


class AchievementResponse(BaseModel):
    """Game achievement information.

    Attributes:
        id: Achievement identifier.
        name: Achievement name.
        description: How to unlock the achievement.
        image: Achievement icon URL.
    """

    id: int
    name: str
    description: Optional[str] = None
    image: Optional[str] = None


class RedditPostResponse(BaseModel):
    """Reddit post about a game.

    Attributes:
        id: Reddit post identifier.
        name: Post title.
        url: URL to the Reddit post.
        image: Post thumbnail image URL.
    """

    id: int
    name: str
    url: str
    image: Optional[str] = None


class SimpleGameResponse(BaseModel):
    """Simplified game information for lists.

    Used for DLCs, series games, and other game lists where
    full GameRecord details aren't needed.

    Attributes:
        id: Game identifier.
        title: Game title.
        image: Cover/background image URL.
        released: Release date.
    """

    id: int
    title: str
    image: Optional[str] = None
    released: Optional[str] = None


class CompatibilityDetail(BaseModel):
    """Compatibility check result for a single component.

    Attributes:
        user: User's hardware specification.
        requirement: Game's requirement specification.
        status: Compatibility status (Passed, Failed, Minimum Met, etc.).
        message: Detailed explanation of the compatibility result.
    """

    user: str
    requirement: str
    status: str
    message: str


class CompatibilityResponse(BaseModel):
    """Complete compatibility check report.

    Analyzes whether user's hardware can run a specific game.

    Attributes:
        game_title: Name of the game being checked.
        user_specs: User's system specifications used for checking.
        report: Detailed compatibility analysis containing:
            - overall: Overall compatibility status
            - details: Per-component analysis (RAM, CPU, GPU, disk)
            - warnings: Any warnings or notes
            - predicted_preset: Predicted graphics quality setting
    """

    game_title: str
    user_specs: Dict[str, Any]
    report: Dict[str, Any]


class SearchResponse(BaseModel):
    """Game search results with pagination.

    Attributes:
        count: Total number of games matching the search.
        next: Next page number, or None if this is the last page.
        results: List of matching games.
    """

    count: int
    next: Optional[int] = None
    results: List[GameRecord]


storeColors: dict[int, str] = {
    # Steam
    1: "66C0F4",
    # Xbox Store
    2: "107C10",
    # PlayStation Store
    3: "0070D1",
    # Epic Games Store
    11: "ffffff",
    # GOG.com
    5: "86328A",
    # itch.io
    9: "FA5C5C",
    # Google Play
    8: "34A853",
    # Apple / App Store / Sign in with Apple
    4: "A3AAAE",
    # XBox 360 store
    7: "92C83E",
}

platformColors: dict[int, str] = {
    # PC
    4: "0078D6",
    # iOS
    3: "0484EB",
    # Android
    21: "A4C639",
    # Xbox
    186: "107C10",
    # Xbox 360
    14: "92C83E",
    # Xbox One
    1: "107C10",
    # PlayStation 5
    187: "006FCD",
    # PlayStation 4
    18: "006FCD",
    # PlayStation 3
    16: "000000",
    # PlayStation 2
    15: "000000",
    # macOS
    5: "A3AAAE",
    # Linux
    6: "FDD835",
    # Nintendo
    7: "E60012",
}
