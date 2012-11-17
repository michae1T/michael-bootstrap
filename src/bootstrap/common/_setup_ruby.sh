#!/bin/bash

THIS_RUBY_PATCH_DIR=$RUBY_PATCH_DIR/ruby/$RUBY_VERSION

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
if [ -d $THIS_RUBY_PATCH_DIR ] ; then
  echo "patching from: $RUBY_PATCH_DIR"
  patch -p1 < $THIS_RUBY_PATCH_DIR/*
fi;

cd $START_DIR

