"""Class settings."""
from pydantic import BaseSettings


class Settings(BaseSettings):
    """Base settings."""

    api_version: str = "0.1.0"

    project_name: str = "FastAPI Base"

    prefix: str = "/api"

    class Config:
        """Base settings config."""

        env_file = ".env"
