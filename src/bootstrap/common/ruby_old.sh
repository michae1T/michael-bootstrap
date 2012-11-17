#!/bin/bash

source _environment.sh

INSTALL_DIR=/opt/ruby-1.8.7
RUBY_TAG=origin/ruby_1_8_7
GEM_TAG=v1.3.7
RUBY_VERSION=1.8.7

RUBY=$INSTALL_DIR/bin/ruby
GEM=$INSTALL_DIR/bin/gem
GEMS_DIR=$INSTALL_DIR/lib/ruby/gems/1.8/gems

source _setup_ruby.sh

rm -rf $INSTALL_DIR > /dev/null

cd $RUBY_SRC
autoconf && CC=gcc34 CXX=g++34 ./configure --prefix=/opt/ruby-1.8.7
make clean && make && make install

cd $GEM_SRC
$RUBY setup.rb 

export PATH=$INSTALL_DIR/bin:$PATH

$GEM install bundler08 thin rdoc \
                             net-ssh-gateway net-ssh net-sftp net-scp

$GEM install rake --version 0.9.2.2

cd $START_DIR && ./ruby_aes.sh

cd $START_DIR && source _fix_ruby_src_owner.sh

### install/patch passenger-nginx ###

$GEM install passenger --version 2.2.9 --no-ri --no-rdoc

BOOST_PATCH_DIR=$RUBY_PATCH_DIR/passenger/boost

if [ -d $BOST_PATCH_DIR ] ; then
  cd $GEMS_DIR/passenger-2.2.9/ext
  patch -p0 < $BOOST_PATCH_DIR/*
fi;

mv /opt/nginx /opt/nginx.bak > /dev/null
rm -rf /opt/nginx > /dev/null

$GEMS_DIR/passenger-2.2.9/bin/passenger-install-nginx-module --auto --auto-download --prefix=/opt/nginx --extra-configure-flags='--with-cc-opt=-Wno-error'

cd $START_DIR

