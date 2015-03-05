#!/bin/bash

IMAGE=`echo $1 | sed 's/\([^\/]*\)\(\/\)*/\1/'`

`dirname $0`/build.sh $IMAGE
sleep 3
docker push "michae1t/$IMAGE:latest"

