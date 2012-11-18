#!/bin/bash

source ../common/_environment.sh

INSTALL_DIR=/opt/ruby-1.8.7
RUBY_TAG=origin/ruby_1_8_7
GEM_TAG=v1.3.7
RUBY_VERSION=1.8.7

RUBY=$INSTALL_DIR/bin/ruby

source $COMMON/_setup_ruby.sh

rm -rf $INSTALL_DIR > /dev/null

cd $RUBY_SRC
autoconf && CC=gcc34 CXX=g++34 ./configure --prefix=/opt/ruby-1.8.7
make clean && make && make install

cd $GEM_SRC
$RUBY setup.rb 

source $COMMON/_fix_ruby_src_owner.sh

