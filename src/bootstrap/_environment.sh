#!/bin/bash

START_DIR=`pwd`

cd `dirname $0`
OWNER_DIR=`pwd`

cd $OWNER_DIR/../shared
SHARED=`pwd`

cd $OWNER_DIR/../../..
USER_HOME=`pwd`
USER_STAT=`stat -c "%U:%G" $OWNER_DIR`

RUBY_PROJECTS=$USER_HOME/src/ruby
RUBY_SRC=$RUBY_PROJECTS/ruby
GEM_SRC=$RUBY_PROJECTS/rubygems
RUBY_PATCH_DIR=$RUBY_PROJECTS/patches

cd $START_DIR

