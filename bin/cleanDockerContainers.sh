#!/usr/bin/env bash

for DOCKER in $(
    sudo docker ps -a \
        | awk '{print $1}' \
        | grep -v CONTAINER
)
do
    echo -n "Deleting container... "
    sudo docker rm $DOCKER
done
