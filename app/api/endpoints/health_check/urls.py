"""Urls."""
from app.core.settings import Settings

from fastapi import APIRouter

from .models import HealthCheck

settings = Settings()
router = APIRouter(tags=["Health Check"])


@router.get("/status", response_model=HealthCheck)
async def health_check():
    """Endpoint health check."""
    return {
        "status_code": 200,
        "api_version": settings.api_version,
    }
