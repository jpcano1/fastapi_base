"""PyDantic models."""
from pydantic import BaseModel, Field
from starlette import status


class HealthCheck(BaseModel):
    """Model health check."""

    status_code: int = Field(..., example=status.HTTP_200_OK)
    api_version = Field(..., example="0.1.0")
