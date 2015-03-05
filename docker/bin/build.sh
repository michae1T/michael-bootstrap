#!/bin/bash

IMAGE=`echo $1 | sed 's/\([^\/]*\)\(\/\)*/\1/'`
docker build -t "michae1t/$IMAGE:latest" $IMAGE


