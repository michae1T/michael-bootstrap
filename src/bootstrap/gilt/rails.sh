#!/bin/bash

source `dirname $0`/../_environment.sh

INSTALL_DIR=/opt/ruby-1.8.7
RUBY=$INSTALL_DIR/bin/ruby
GEM=$INSTALL_DIR/bin/gem
GEMS_DIR=$INSTALL_DIR/lib/ruby/gems/1.8/gems

export PATH=$INSTALL_DIR/bin:$PATH

### required system gems ###

$GEM install bundler08 thin rdoc capistrano \
                             net-ssh-gateway net-ssh net-sftp net-scp

$GEM install rake --version 0.9.2.2

### encyription stuff? ###

source $SHARED/_ruby_aes.sh

### install/patch passenger-nginx ###

$GEM install passenger --version 2.2.9 --no-ri --no-rdoc

BOOST_PATCH_DIR=$RUBY_PATCH_DIR/passenger/boost

if [ -d $BOST_PATCH_DIR ] ; then
  cd $GEMS_DIR/passenger-2.2.9/ext
  patch -p0 < $BOOST_PATCH_DIR/*
fi;

mv /opt/nginx /opt/nginx.bak > /dev/null 2>&1
rm -rf /opt/nginx

$GEMS_DIR/passenger-2.2.9/bin/passenger-install-nginx-module --auto --auto-download --prefix=/opt/nginx --extra-configure-flags='--with-cc-opt=-Wno-error'

cd $START_DIR

