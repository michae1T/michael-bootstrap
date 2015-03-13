#!/bin/bash

. `dirname $0`/_shared.sh

`dirname $0`/build.sh $IMAGE_NAME $TAG

sleep 3

docker push "$IMAGE_URI"

