from typing import Optional

from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    RAWG_API_KEY: Optional[str] = None
    IGDB_CLIENT_ID: Optional[str] = None
    IGDB_CLIENT_SECRET: Optional[str] = None

    @classmethod
    def load(cls):
        # specific logic to load from secrets_generated if present
        try:
            from core.secrets_generated import Secrets

            return cls(
                RAWG_API_KEY=getattr(Secrets, "RAWG_API_KEY", None),
                IGDB_CLIENT_ID=getattr(Secrets, "IGDB_CLIENT_ID", None),
                IGDB_CLIENT_SECRET=getattr(Secrets, "IGDB_CLIENT_SECRET", None),
            )
        except ImportError:
            return cls()


settings = Settings.load()
