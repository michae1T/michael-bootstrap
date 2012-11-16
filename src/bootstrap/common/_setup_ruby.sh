#!/bin/bash

START_DIR=`pwd`

cd `dirname $0`/../../..
USER_HOME=`pwd`
USER_STAT=`stat -c "%U:%G" $START_DIR/$0`
RUBY_PROJECTS=$USER_HOME/src/ruby
RUBY_SRC=$RUBY_PROJECTS/ruby
GEM_SRC=$RUBY_PROJECTS/rubygems
PATCH_DIR=$RUBY_PROJECTS/patches
RUBY_PATCH_DIR=$PATCH_DIR/ruby/$RUBY_VERSION

mkdir -p $RUBY_PROJECTS > /dev/null

if [ -d $RUBY_SRC ]
  then cd $RUBY_SRC && git add . && git reset --hard && git fetch
  else cd $RUBY_PROJECTS && git clone https://github.com/ruby/ruby.git
fi
cd $RUBY_SRC && git checkout $RUBY_TAG

if [ -d $GEM_SRC ]
  then cd $GEM_SRC && git add . && git reset --hard && git fetch
  else cd $RUBY_PROJECTS && git clone https://github.com/rubygems/rubygems.git
fi
cd $GEM_SRC && git checkout $GEM_TAG

# patch ruby if necessary
cd $RUBY_SRC
if [ -d $RUBY_PATCH_DIR ] ; then
  echo "patching from: $RUBY_PATCH_DIR"
  patch -p1 < $RUBY_PATCH_DIR/*
fi;

cd $START_DIR

