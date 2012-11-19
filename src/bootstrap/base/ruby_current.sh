#!/bin/bash

source `dirname $0`/../_environment.sh

INSTALL_DIR=/opt/ruby-1.9.3
RUBY_TAG=origin/ruby_1_9_3
GEM_TAG=origin/1.8
RUBY_VERSION=1.9.3

source $SHARED/_setup_ruby.sh

rm -rf $INSTALL_DIR 

cd $RUBY_SRC
autoconf && ./configure --prefix=$INSTALL_DIR
make clean > /dev/null 2>&1
make && make install

cd $GEM_SRC
$INSTALL_DIR/bin/ruby setup.rb 

cd $START_DIR
source $SHARED/_fix_ruby_src_owner.sh

