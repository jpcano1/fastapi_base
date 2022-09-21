#!/bin/bash -e

ENV=${ENV:-'poetry'}
IMAGE_NAME=${IMAGE_NAME:-"fastapi_base"}
IMAGE_TAG=${DOCKER_IMAGE_TAG:-'dev'}
VOLUME=$(pwd)/app:/app

if [ "$ENV" = "poetry" ]; then
    echo "Running on poetry"
    poetry run isort ./app --check
    poetry run black --check --diff --color ./app
    poetry run mypy ./app
    poetry run pydocstyle ./app
    poetry run flake8 ./app
else
    echo "Running on docker"
    docker run -v "$VOLUME" --rm "${IMAGE_NAME}":"${IMAGE_TAG}" black --check --diff --color ./app
    docker run -v "$VOLUME" --rm "${IMAGE_NAME}":"${IMAGE_TAG}" isort ./app --check
    docker run -v "$VOLUME" --rm "${IMAGE_NAME}":"${IMAGE_TAG}" mypy ./app
    docker run -v "$VOLUME" --rm "${IMAGE_NAME}":"${IMAGE_TAG}" pydocstyle ./app
    docker run -v "$VOLUME" --rm "${IMAGE_NAME}":"${IMAGE_TAG}" flake8 ./app
fi