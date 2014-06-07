#!/usr/bin/env bash

for IMAGE in $(
    sudo docker images \
        | awk '{print $3}' \
        | grep -v REPOSITORY)
do
	
    echo -n "Deleting image... "
    sudo docker rmi $IMAGE
done
