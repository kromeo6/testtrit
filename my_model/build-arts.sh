#!/bin/bash

CONTAINER_NAME=my_artifact_container
IMAGE_NAME=my-image
ARTIFACT_PATH="/artifacts"
DESTINATION_PATH="./artifacts-output" # Path on the host

docker run -d --name $CONTAINER_NAME $IMAGE_NAME tail -f /dev/null

if [ $? -ne 0 ]; then
    echo "Failed to start the container."
    exit 1
fi

mkdir -p $DESTINATION_PATH

docker cp $CONTAINER_NAME:$ARTIFACT_PATH/. $DESTINATION_PATH/

# Check if the copy was successful
if [ $? -ne 0 ]; then
    echo "Failed to copy artifacts from the container."
    docker rm -f $CONTAINER_NAME
    exit 1
fi

echo "Artifacts copied to $DESTINATION_PATH."

docker rm -f $CONTAINER_NAME
