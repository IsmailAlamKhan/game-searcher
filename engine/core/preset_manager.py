import json
import logging
from typing import List, Optional
from pathlib import Path
from .models import SearchPreset
from .logger import get_app_data_dir

logger = logging.getLogger(__name__)

class PresetManager:
    def __init__(self, app_name: str = "GameSearch Studio"):
        self.app_data_dir = get_app_data_dir(app_name)
        self.presets_dir = self.app_data_dir / "presets"
        self.presets_dir.mkdir(parents=True, exist_ok=True)
        self._ensure_default_presets()

    def _ensure_default_presets(self):
        """Create default presets if none exist."""
        if not (self.presets_dir / "jiggle_physics.json").exists():
            default = SearchPreset(
                id="jiggle_physics",
                name="Jiggle Physics Games",
                description="Search for games with jiggle physics",
                query={
                    "query": None, 
                    "tags": ["jiggle-physics"], 
                    "limit": 20
                }
            )
            self.save_preset(default)

    def list_presets(self) -> List[SearchPreset]:
        presets = []
        for file_path in self.presets_dir.glob("*.json"):
            try:
                with open(file_path, 'r', encoding='utf-8') as f:
                    data = json.load(f)
                    presets.append(SearchPreset(**data))
            except Exception as e:
                logger.error(f"Failed to load preset {file_path}: {e}")
        return presets

    def get_preset(self, preset_id: str) -> Optional[SearchPreset]:
        file_path = self.presets_dir / f"{preset_id}.json"
        if not file_path.exists():
            return None
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                data = json.load(f)
                return SearchPreset(**data)
        except Exception as e:
            logger.error(f"Failed to load preset {preset_id}: {e}")
            return None

    def save_preset(self, preset: SearchPreset) -> SearchPreset:
        file_path = self.presets_dir / f"{preset.id}.json"
        try:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(preset.model_dump_json(indent=2))
            return preset
        except Exception as e:
            logger.error(f"Failed to save preset {preset.id}: {e}")
            raise e

    def delete_preset(self, preset_id: str) -> bool:
        file_path = self.presets_dir / f"{preset_id}.json"
        if file_path.exists():
            try:
                file_path.unlink()
                return True
            except Exception as e:
                logger.error(f"Failed to delete preset {preset_id}: {e}")
                return False
        return False
