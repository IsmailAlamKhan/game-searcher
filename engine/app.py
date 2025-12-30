from fastapi import FastAPI, HTTPException, Query
from typing import List, Optional
import logging

from core.engine_core import GameSearchEngine
from core.models import GameRecord, SearchQuery, SearchPreset, Tag
from core.preset_manager import PresetManager

from core.logger import setup_logging
from core.compatibility import check_compatibility
from core.system_info import get_system_specs
setup_logging()

logger = logging.getLogger()

app = FastAPI(title="GameSearch Engine")

# Initialize Engine and Manager
engine = GameSearchEngine()
preset_manager = PresetManager()

@app.get("/health")
def health_check():
    logger.info("Health check endpoint called")
    return {"status": "ok", "engine": "ready"}

# --- Search Endpoints ---

@app.get("/search", response_model=List[GameRecord])
def search_games(
    q: Optional[str] = Query(None, description="Search query"),
    tags: Optional[List[str]] = Query(None, description="Tags/Integers"),
    page_size: int = Query(20, description="Max results"),
    page: int = Query(1, description="Page number")
):
    query = SearchQuery(query=q, page_size=page_size, tags=tags, page=page)
    results = engine.search(query)
    return results

@app.get("/game/{game_id}", response_model=GameRecord)
def get_game_details(game_id: str, source: str = Query("rawg", description="Source ID")):
    try:
        game = engine.get_game_details(game_id, source)
        if not game:
            raise HTTPException(status_code=404, detail="Game not found")
        return game
    except Exception as e:
        logger.error(f"Failed to get game details for {game_id}: {e}", exc_info=True)
        raise HTTPException(status_code=500, detail=f"Failed to get game details: {str(e)}")

@app.get('/game/{game_id}/screenshots', response_model=dict)
def get_game_screenshots(game_id: str, page: int = Query(1, ge=1), page_size: int = Query(20, le=100), source: str = Query("rawg", description="Source ID")):
    screenshots = engine.get_game_screenshots(game_id, page=page, page_size=page_size, source=source)
    return screenshots

@app.get('/game/{game_id}/trailers', response_model=dict)
def get_game_trailers(game_id: str, page: int = Query(1, ge=1), page_size: int = Query(20, le=100), source: str = Query("rawg", description="Source ID")):
    trailers = engine.get_game_trailers(game_id, page=page, page_size=page_size, source=source)
    return trailers
    

@app.get('/game/{game_id}/achievements', response_model=dict)
def get_game_achievements(game_id: str, page: int = Query(1, ge=1), page_size: int = Query(20, le=100), source: str = Query("rawg", description="Source ID")):
    achievements = engine.get_game_achievements(game_id, page=page, page_size=page_size, source=source)
    return achievements

@app.get('/game/{game_id}/reddit', response_model=dict)
def get_game_reddit(game_id: str, page: int = Query(1, ge=1), page_size: int = Query(20, le=100), source: str = Query("rawg", description="Source ID")):
    reddit = engine.get_game_reddit(game_id, page=page, page_size=page_size, source=source)
    return reddit

@app.get('/game/{game_id}/dlcs', response_model=dict)
def get_game_dlcs(game_id: str, page: int = Query(1, ge=1), page_size: int = Query(20, le=100), source: str = Query("rawg", description="Source ID")):
    dlcs = engine.get_game_dlcs(game_id, page=page, page_size=page_size, source=source)
    return dlcs

@app.get('/game/{game_id}/same_series', response_model=dict)
def get_game_same_series(game_id: str, page: int = Query(1, ge=1), page_size: int = Query(20, le=100), source: str = Query("rawg", description="Source ID")):
    same_series = engine.get_game_same_series(game_id, page=page, page_size=page_size, source=source)
    return same_series

@app.get("/tags", response_model=List[Tag])
def get_tags(
    q: Optional[str] = None, 
    page: int = Query(1, ge=1), 
    page_size: int = Query(20, le=100)
):
    results = engine.get_tags(q, page, page_size)
    return results

# --- Preset Endpoints ---

@app.get("/presets", response_model=List[SearchPreset])
def list_presets():
    return preset_manager.list_presets()

@app.get("/presets/{preset_id}", response_model=SearchPreset)
def get_preset(preset_id: str):
    preset = preset_manager.get_preset(preset_id)
    if not preset:
        raise HTTPException(status_code=404, detail="Preset not found")
    return preset

@app.post("/presets", response_model=SearchPreset)
def create_or_update_preset(preset: SearchPreset):
    try:
        saved = preset_manager.save_preset(preset)
        return saved
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.delete("/presets/{preset_id}")
def delete_preset(preset_id: str):
    success = preset_manager.delete_preset(preset_id)
    if not success:
        raise HTTPException(status_code=404, detail="Preset not found")
    return {"status": "deleted", "id": preset_id}

@app.get("/run/{preset_id}", response_model=List[GameRecord])
def run_preset(preset_id: str):
    """
    Execute the search defined in a preset.
    """
    preset = preset_manager.get_preset(preset_id)
    if not preset:
        raise HTTPException(status_code=404, detail="Preset not found")
        
    results = engine.search(preset.query)
    return results

@app.post("/game/{game_id}/can-run-it")
def check_game_compatibility(game_id: str, specs: Optional[dict] = None, source: str = Query("rawg")):
    """
    Check if the game can run on the given specs. 
    If no specs are provided, use the current system specs.
    """
    try:
        # 1. Get Game Details (includes requirements)
        game = engine.get_game_details(game_id, source)
        if not game:
            raise HTTPException(status_code=404, detail="Game not found")
        
        # RAWG requirements are under platforms -> PC
        pc_platform = next((p for p in game.platforms if p.name.lower() == "pc"), None)
        if not pc_platform or not pc_platform.requirements:
            raise HTTPException(status_code=404, detail="PC requirements not found for this game")
        
        requirements = {
            "minimum": pc_platform.requirements.minimum,
            "recommended": pc_platform.requirements.recommended
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
        
        return {
            "game_title": game.title,
            "user_specs": user_specs,
            "report": report
        }

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Error checking compatibility for {game_id}: {e}", exc_info=True)
        raise HTTPException(status_code=500, detail=str(e))