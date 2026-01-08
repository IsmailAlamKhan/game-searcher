"""GameHunter Engine - Configuration Management.

This module handles application configuration loading from environment variables.
Configuration values are loaded from a .env file or system environment variables.

Configuration:
    RAWG_API_KEY: API key for RAWG.io game database
    IGDB_CLIENT_ID: Client ID for IGDB API (future use)
    IGDB_CLIENT_SECRET: Client secret for IGDB API (future use)
"""

import os
from typing import Optional

from dotenv import load_dotenv
from pydantic_settings import BaseSettings

load_dotenv()


class Settings(BaseSettings):
    """Application configuration settings.

    Manages all configuration values loaded from environment variables.
    Uses Pydantic for validation and type safety.

    Attributes:
        RAWG_API_KEY: API key for accessing RAWG.io game database.
        APP_SECRET: API secret for accessing GameHunter Engine.
        GROQ_API_KEY: API key for accessing Groq AI.
    """

    RAWG_API_KEY: Optional[str] = None
    APP_SECRET: Optional[str] = None
    GROQ_API_KEY: Optional[str] = None

    @classmethod
    def load(cls):
        """Load configuration from environment variables.

        Reads configuration values from environment variables (via .env file or system).

        Returns:
            Settings: Configured Settings instance with loaded values.
        """
        return cls(
            RAWG_API_KEY=os.getenv("RAWG_API_KEY"),
            APP_SECRET=os.getenv("APP_SECRET"),
            GROQ_API_KEY=os.getenv("GROQ_API_KEY"),
        )

    def to_dict(self):
        """Convert settings to dictionary format.

        Returns:
            dict: Settings as key-value pairs.
        """
        return {
            "rawg_api_key": self.RAWG_API_KEY,
        }


settings = Settings.load()
