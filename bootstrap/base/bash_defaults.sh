#!/bin/bash

source `dirname $0`/../_environment.sh
require_root

OWNER_BASH_DIR=$SCRIPTS_DIR/bash-defaults
SHARED_BASH_DIR=/opt/scripts/bash-defaults
SHARED_LOADER=$SHARED_BASH_DIR/bin/dot-loader

echo "updating $SHARED_BASH_DIR"
rm -rf $SHARED_BASH_DIR
mkdir -p /opt/scripts/..
cp -r $OWNER_BASH_DIR $SHARED_BASH_DIR

OWNER_SUB="`path_regex $OWNER_BASH_DIR` # written `date`"
sed -i "s/###ORIGINALPATH###/$OWNER_SUB/" $SHARED_LOADER

REPO_SUB="`path_regex $REPO_DIR` # written `date`"
sed -i "s/###REPOPATH###/$REPO_SUB/" $SHARED_LOADER

su - $USER_OWNER -c "DOCKER_IMAGE_NAME=$DOCKER_IMAGE_NAME $SHARED_LOADER link"

