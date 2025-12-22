from pydantic_settings import BaseSettings
from typing import Optional

class Settings(BaseSettings):
    RAWG_API_KEY: Optional[str] = None
    IGDB_CLIENT_ID: Optional[str] = None
    IGDB_CLIENT_SECRET: Optional[str] = None
    
    class Config:
        env_file = ".env"

settings = Settings()
