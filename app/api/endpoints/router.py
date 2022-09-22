"""API router."""

from fastapi import APIRouter

from .health_check.urls import router as health_check

api_router = APIRouter()
api_router.include_router(health_check)
