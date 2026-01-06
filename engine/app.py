"""GameHunter Engine - FastAPI Application.

This module provides the main FastAPI application for the GameHunter Engine,
offering endpoints for game search, details, media, and system compatibility checking.

Endpoints:
    - /health: Health check and status
    - /search: Search games with filters
    - /game/{game_id}: Get detailed game information
    - /game/{game_id}/screenshots: Get game screenshots
    - /game/{game_id}/trailers: Get game trailers
    - /game/{game_id}/achievements: Get game achievements
    - /game/{game_id}/reddit: Get Reddit posts about the game
    - /game/{game_id}/dlcs: Get DLCs and editions
    - /game/{game_id}/same_series: Get games in the same series
    - /tags: Search and retrieve game tags
    - /game/{game_id}/can-run-it: Check PC compatibility
"""

import logging
from typing import List, Optional

from clients.rawg import RawgClient
from core.compatibility import check_compatibility
from core.models import (
    CompatibilityResponse,
    GameRecord,
    PaginatedResponse,
    SearchQuery,
    SearchResponse,
)
from core.system_info import get_system_specs
from fastapi import FastAPI, HTTPException, Query

# Logger will be configured by main.py's setup_logging()
logger = logging.getLogger(__name__)


app = FastAPI(title="GameHunter Engine")


# @app.middleware("http")
# async def auth_middleware(request: Request, call_next):
#     app_secret = request.headers.get("APP_SECRET")
#     if settings.APP_SECRET:
#         if not app_secret or app_secret != settings.APP_SECRET:
#             return JSONResponse(status_code=401, content={"detail": "Unauthorized"})
#     return await call_next(request)


# Initialize Engine and Manager
client = RawgClient()


@app.get("/health")
def health_check():
    """Health check endpoint.

    Returns the engine status and configuration to verify the service is running.

    Returns:
        dict: Status information including engine readiness.
    """
    logger.info("Health check endpoint called")

    return {"status": "ok", "engine": "ready"}


# --- Search Endpoints ---


@app.get("/search", response_model=SearchResponse)
def search_games(
    q: Optional[str] = Query(None, description="Search query string"),
    tags: Optional[List[str]] = Query(None, description="Filter by tag slugs or IDs"),
    page_size: int = Query(
        20, description="Maximum number of results per page (default: 20)"
    ),
    page: int = Query(1, description="Page number for pagination (default: 1)"),
    search_precise: Optional[bool] = Query(
        None, description="Enable precise search matching"
    ),
    search_exact: Optional[bool] = Query(
        None, description="Enable exact search matching"
    ),
    ordering: Optional[str] = Query(
        None, description="Order results by field (e.g., 'name', 'released', '-rating')"
    ),
    platform: Optional[List[int]] = Query(None, description="Filter by platform IDs"),
    genres: Optional[List[str]] = Query(None, description="Filter by genre slugs"),
):
    """Search for games with various filters.

    Searches the game database using query parameters and filters. Supports full-text search,
    filtering by tags, genres, platforms, and custom ordering.

    Args:
        q: Search query string to match against game titles and descriptions.
        tags: List of tag slugs or IDs to filter results.
        page_size: Number of results to return per page.
        page: Page number for pagination.
        search_precise: Enable more precise matching of search terms.
        search_exact: Require exact matches for search terms.
        ordering: Field to order results by (prefix with '-' for descending).
        platform: Filter games by platform IDs.
        genres: Filter games by genre slugs.

    Returns:
        SearchResponse: Search results with count, next page, and list of GameRecord objects.
    """
    query = SearchQuery(
        query=q,
        page_size=page_size,
        tags=tags,
        page=page,
        search_precise=search_precise,
        search_exact=search_exact,
        ordering=ordering,
        platform=platform,
        genres=genres,
    )
    results = client.search_games(query)
    return results


@app.get("/game/{game_id}", response_model=GameRecord)
def get_game_details(game_id: str):
    """Get detailed information about a specific game.

    Retrieves comprehensive game information including description, platforms,
    stores, ratings, release date, and requirements.

    Args:
        game_id: Unique identifier for the game.

    Returns:
        GameRecord: Complete game information.

    Raises:
        HTTPException: 404 if game not found, 500 if retrieval fails.
    """
    try:
        game = client.get_game_details(game_id)

        if not game:
            raise HTTPException(status_code=404, detail="Game not found")
        return game

    except Exception as e:
        logger.error(f"Failed to get game details for {game_id}: {e}", exc_info=True)

        raise HTTPException(
            status_code=500, detail=f"Failed to get game details: {str(e)}"
        )


@app.get("/game/{game_id}/screenshots", response_model=PaginatedResponse)
def get_game_screenshots(
    game_id: str,
    page: int = Query(1, ge=1, description="Page number (minimum: 1)"),
    page_size: int = Query(20, le=100, description="Results per page (maximum: 100)"),
):
    """Get screenshots for a specific game.

    Retrieves paginated screenshots with image URLs and metadata.

    Args:
        game_id: Unique identifier for the game.
        page: Page number for pagination.
        page_size: Number of screenshots per page (max 100).

    Returns:
        PaginatedResponse: Paginated screenshots with count, next page, and Screenshot objects.
    """
    screenshots = client.get_game_screenshots(game_id, page=page, page_size=page_size)
    return screenshots


@app.get("/game/{game_id}/trailers", response_model=PaginatedResponse)
def get_game_trailers(
    game_id: str,
    page: int = Query(1, ge=1, description="Page number (minimum: 1)"),
    page_size: int = Query(20, le=100, description="Results per page (maximum: 100)"),
):
    """Get trailers and video content for a specific game.

    Retrieves paginated video trailers with URLs and preview images.

    Args:
        game_id: Unique identifier for the game.
        page: Page number for pagination.
        page_size: Number of trailers per page (max 100).

    Returns:
        PaginatedResponse: Paginated trailers with count, next page, and trailer details.
    """
    trailers = client.get_game_trailers(game_id, page=page, page_size=page_size)
    return trailers


@app.get("/game/{game_id}/achievements", response_model=PaginatedResponse)
def get_game_achievements(
    game_id: str,
    page: int = Query(1, ge=1, description="Page number (minimum: 1)"),
    page_size: int = Query(20, le=100, description="Results per page (maximum: 100)"),
):
    """Get achievements for a specific game.

    Retrieves paginated achievements with names, descriptions, and unlock percentages.

    Args:
        game_id: Unique identifier for the game.
        page: Page number for pagination.
        page_size: Number of achievements per page (max 100).

    Returns:
        PaginatedResponse: Paginated achievements with names, descriptions, and images.
    """
    achievements = client.get_game_achievements(game_id, page=page, page_size=page_size)
    return achievements


@app.get("/game/{game_id}/reddit", response_model=PaginatedResponse)
def get_game_reddit(
    game_id: str,
    page: int = Query(1, ge=1, description="Page number (minimum: 1)"),
    page_size: int = Query(20, le=100, description="Results per page (maximum: 100)"),
):
    """Get Reddit posts about a specific game.

    Retrieves paginated Reddit posts related to the game from gaming subreddits.

    Args:
        game_id: Unique identifier for the game.
        page: Page number for pagination.
        page_size: Number of posts per page (max 100).

    Returns:
        PaginatedResponse: Paginated Reddit posts with titles, URLs, and thumbnails.
    """
    reddit = client.get_game_reddit(game_id, page=page, page_size=page_size)
    return reddit


@app.get("/game/{game_id}/dlcs", response_model=PaginatedResponse)
def get_game_dlcs(
    game_id: str,
    page: int = Query(1, ge=1, description="Page number (minimum: 1)"),
    page_size: int = Query(20, le=100, description="Results per page (maximum: 100)"),
):
    """Get DLCs and editions for a specific game.

    Retrieves downloadable content, expansions, and special editions for the game.

    Args:
        game_id: Unique identifier for the game.
        page: Page number for pagination.
        page_size: Number of DLCs per page (max 100).

    Returns:
        PaginatedResponse: Paginated DLCs with game details and release information.
    """
    dlcs = client.get_game_dlcs(game_id, page=page, page_size=page_size)
    return dlcs


@app.get("/game/{game_id}/same_series", response_model=PaginatedResponse)
def get_game_same_series(
    game_id: str,
    page: int = Query(1, ge=1, description="Page number (minimum: 1)"),
    page_size: int = Query(20, le=100, description="Results per page (maximum: 100)"),
):
    """Get games in the same series as the specified game.

    Retrieves other games that belong to the same franchise or series.

    Args:
        game_id: Unique identifier for the game.
        page: Page number for pagination.
        page_size: Number of games per page (max 100).

    Returns:
        PaginatedResponse: Paginated games from the same series.
    """
    same_series = client.get_game_same_series(game_id, page=page, page_size=page_size)
    return same_series


@app.get("/tags", response_model=PaginatedResponse)
def get_tags(
    q: Optional[str] = Query(None, description="Search query to filter tags"),
    page: int = Query(1, ge=1, description="Page number (minimum: 1)"),
    page_size: int = Query(20, le=100, description="Results per page (maximum: 100)"),
):
    """Search and retrieve game tags.

    Returns available tags that can be used to filter games. Optionally search
    for specific tags by name.

    Args:
        q: Optional search query to filter tags by name.
        page: Page number for pagination.
        page_size: Number of tags per page (max 100).

    Returns:
        PaginatedResponse: Paginated tags with IDs, names, slugs, and game counts.
    """
    results = client.get_tags(query=q, page=page, page_size=page_size)
    return results


@app.post("/game/{game_id}/can-run-it", response_model=CompatibilityResponse)
def check_game_compatibility(game_id: str, specs: Optional[dict] = None):
    """Check if a game can run on specified or current system specs.

    Analyzes game requirements against user's hardware specifications to determine
    compatibility. If no specs are provided, automatically detects current system specs.
    Provides detailed compatibility report for minimum and recommended requirements.

    Args:
        game_id: Unique identifier for the game.
        specs: Optional dictionary of user specifications. If not provided, uses local system.
            Expected format: {"cpu": str, "ram": int, "gpu": str, "disk_free": int}
            Can also accept {"user_specs": {...}} wrapper format.

    Returns:
        CompatibilityResponse: Compatibility report containing game_title, user_specs,
            and detailed analysis with overall status, per-component results (RAM, CPU, GPU, disk),
            and predicted graphics preset.

    Raises:
        HTTPException: 404 if game or PC requirements not found, 500 if analysis fails.
    """

    try:
        # 1. Get Game Details (includes requirements)
        game = client.get_game_details(game_id)

        if not game:
            raise HTTPException(status_code=404, detail="Game not found")

        # RAWG requirements are under platforms -> PC

        pc_platform = next((p for p in game.platforms if p.name.lower() == "pc"), None)

        if not pc_platform or not pc_platform.requirements:
            raise HTTPException(
                status_code=404, detail="PC requirements not found for this game"
            )

        requirements = {
            "minimum": pc_platform.requirements.minimum,
            "recommended": pc_platform.requirements.recommended,
        }

        # 2. Get User Specs (provided or local)

        local_specs = get_system_specs()

        provided_specs = specs if specs else {}

        # Handle common "user_specs" wrapper in request body

        if "user_specs" in provided_specs:
            provided_specs = provided_specs["user_specs"]

        # Merge: Provided specs override local specs

        user_specs = {**local_specs, **provided_specs}

        # 3. Check Compatibility

        report = check_compatibility(user_specs, requirements)

        return CompatibilityResponse(
            game_title=game.title, user_specs=user_specs, report=report
        )

    except HTTPException:
        raise

    except Exception as e:
        logger.error(f"Error checking compatibility for {game_id}: {e}", exc_info=True)

        raise HTTPException(status_code=500, detail=str(e))
