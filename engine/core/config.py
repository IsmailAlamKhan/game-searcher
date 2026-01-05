import os
from typing import Optional

from dotenv import load_dotenv
from pydantic_settings import BaseSettings

load_dotenv()


class Settings(BaseSettings):
    RAWG_API_KEY: Optional[str] = None

    @classmethod
    def load(cls):
        RAWG_API_KEY = os.getenv("RAWG_API_KEY")
        return cls(
            RAWG_API_KEY=RAWG_API_KEY,
        )

    def to_dict(self):
        return {
            "rawg_api_key": self.RAWG_API_KEY,
        }


settings = Settings.load()
