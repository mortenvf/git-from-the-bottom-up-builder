#!/bin/bash

DOCKER_IMAGE="git-from-the-bottom-up-builder"

docker build \
    --build-arg USER_ID=$(id -u ${USER}) \
    --build-arg GROUP_ID=$(id -g ${USER}) \
    --tag "$DOCKER_IMAGE" \
    .

docker run \
    --rm \
    -v "$PWD:/git-from-the-bottom-up-builder" \
    --workdir "/git-from-the-bottom-up-builder" \
    "git-from-the-bottom-up-builder" \
    bash -c "./make-meta.sh;./make-pdf.sh;./make-epub.sh;"
