#!/bin/bash -e

IMAGE_NAME=${IMAGE_NAME:-"fastapi_base"}
IMAGE_TAG=${DOCKER_IMAGE_TAG:-'dev'}
IMAGE_FILE=Dockerfile

cmd=$1
shift

case ${cmd} in
    h | help)
        # self-print to stdout.
        cat $0 | less
        ;;

    b | build)
        echo "Building image"
        docker build --build-arg ENV="dev" \
            -t "${IMAGE_NAME}":"${IMAGE_TAG}" \
            -f "${IMAGE_FILE}" .
        ;;
esac