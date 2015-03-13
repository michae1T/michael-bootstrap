#!/bin/bash

. `dirname $0`/_shared.sh

docker build -t "$IMAGE_URI" $CONEXT_PATH

