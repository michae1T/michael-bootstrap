#!/bin/bash

START_DIR=`pwd`

cd `dirname $0`
OWNER_DIR=`pwd`

cd $OWNER_DIR/../shared
SHARED=`pwd`

cd $OWNER_DIR/../../..
USER_HOME=`pwd`
USER_STAT=`stat -c "%U:%G" $OWNER_DIR`
USER_OWNER=`stat -c "%U" $OWNER_DIR`

RUBY_PROJECTS=$USER_HOME/src/ruby
RUBY_PATCH_DIR=$RUBY_PROJECTS/patches

cd $START_DIR

checkout_and_patch_repo() {
  SRC_DIR=$1
  PROJECT_NAME=$2
  GIT_REPO=$3
  TAG=$4
  PATCH_DIR=$5

  mkdir -p $SRC_DIR

  PROJECT_DIR=$SRC_DIR/$PROJECT_NAME

  if [ -d "$PROJECT_DIR" ] ;
    then cd $PROJECT_DIR && git add . && git reset --hard && git fetch
    else cd $SRC_DIR && git clone $GIT_REPO
  fi;
  cd $PROJECT_DIR && git checkout $TAG

  if [ -n "$PATCH_DIR" ] && [ -d "$PATCH_DIR" ] ; then
    cd $PROJECT_DIR
    echo "patching from: $PATCH_DIR"
    cat $PATCH_DIR/* | patch -p1
  fi;

  chown -R $USER_STAT $PROJECT_DIR

}

checkout_repo() {
  checkout_and_patch_repo "$1" "$2" "$3" "$4" ""
}

