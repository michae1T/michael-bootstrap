#!/bin/bash

. `dirname $0`/_shared.sh

docker push "$IMAGE_URI"

