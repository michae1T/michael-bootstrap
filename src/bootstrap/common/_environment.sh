#!/bin/bash

START_DIR=`pwd`
COMMON=$START_DIR/../common

cd `dirname $0`/../../..
USER_HOME=`pwd`
USER_STAT=`stat -c "%U:%G" $START_DIR/$0`
RUBY_PROJECTS=$USER_HOME/src/ruby
RUBY_SRC=$RUBY_PROJECTS/ruby
GEM_SRC=$RUBY_PROJECTS/rubygems
RUBY_PATCH_DIR=$RUBY_PROJECTS/patches

cd $START_DIR

