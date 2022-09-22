"""Main app."""

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from .api.endpoints.router import api_router
from .core.settings import Settings

settings = Settings()

app = FastAPI(
    version=settings.api_version,
    title=settings.project_name,
    docs_url=f"{settings.prefix}/docs",
)

app.include_router(api_router)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
)
