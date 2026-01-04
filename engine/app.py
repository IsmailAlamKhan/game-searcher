import logging
from typing import List, Optional

from clients.rawg import RawgClient
from core.compatibility import check_compatibility
from core.models import GameRecord, SearchQuery
from core.system_info import get_system_specs
from fastapi import FastAPI, HTTPException, Query

# Logger will be configured by main.py's setup_logging()
logger = logging.getLogger(__name__)


app = FastAPI(title="GameHunter Engine")


# Initialize Engine and Manager
client = RawgClient()


@app.get("/health")
def health_check():
    logger.info("Health check endpoint called")

    return {"status": "ok", "engine": "ready"}


# --- Search Endpoints ---


@app.get("/search", response_model=dict)
def search_games(
    q: Optional[str] = Query(None, description="Search query"),
    tags: Optional[List[str]] = Query(None, description="Tags/Integers"),
    page_size: int = Query(20, description="Max results"),
    page: int = Query(1, description="Page number"),
    search_precise: Optional[bool] = Query(None, description="Search precise"),
    search_exact: Optional[bool] = Query(None, description="Search exact"),
    ordering: Optional[str] = Query(None, description="Ordering"),
    platform: Optional[List[int]] = Query(None, description="Platform"),
    genres: Optional[List[str]] = Query(None, description="Genres"),
):
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


@app.get("/game/{game_id}/screenshots", response_model=dict)
def get_game_screenshots(
    game_id: str,
    page: int = Query(1, ge=1),
    page_size: int = Query(20, le=100),
):
    screenshots = client.get_game_screenshots(game_id, page=page, page_size=page_size)
    return screenshots


@app.get("/game/{game_id}/trailers", response_model=dict)
def get_game_trailers(
    game_id: str,
    page: int = Query(1, ge=1),
    page_size: int = Query(20, le=100),
):
    trailers = client.get_game_trailers(game_id, page=page, page_size=page_size)
    return trailers


@app.get("/game/{game_id}/achievements", response_model=dict)
def get_game_achievements(
    game_id: str,
    page: int = Query(1, ge=1),
    page_size: int = Query(20, le=100),
):
    achievements = client.get_game_achievements(game_id, page=page, page_size=page_size)
    return achievements


@app.get("/game/{game_id}/reddit", response_model=dict)
def get_game_reddit(
    game_id: str,
    page: int = Query(1, ge=1),
    page_size: int = Query(20, le=100),
):
    reddit = client.get_game_reddit(game_id, page=page, page_size=page_size)
    return reddit


@app.get("/game/{game_id}/dlcs", response_model=dict)
def get_game_dlcs(
    game_id: str,
    page: int = Query(1, ge=1),
    page_size: int = Query(20, le=100),
):
    dlcs = client.get_game_dlcs(game_id, page=page, page_size=page_size)
    return dlcs


@app.get("/game/{game_id}/same_series", response_model=dict)
def get_game_same_series(
    game_id: str,
    page: int = Query(1, ge=1),
    page_size: int = Query(20, le=100),
):
    same_series = client.get_game_same_series(game_id, page=page, page_size=page_size)
    return same_series


@app.get("/tags", response_model=Optional[dict])
def get_tags(
    q: Optional[str] = None,
    page: int = Query(1, ge=1),
    page_size: int = Query(20, le=100),
):
    results = client.get_tags(query=q, page=page, page_size=page_size)
    return results


@app.post("/game/{game_id}/can-run-it")
def check_game_compatibility(game_id: str, specs: Optional[dict] = None):
    """

    Check if the game can run on the given specs.

    If no specs are provided, use the current system specs.
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

        return {"game_title": game.title, "user_specs": user_specs, "report": report}

    except HTTPException:
        raise

    except Exception as e:
        logger.error(f"Error checking compatibility for {game_id}: {e}", exc_info=True)

        raise HTTPException(status_code=500, detail=str(e))
