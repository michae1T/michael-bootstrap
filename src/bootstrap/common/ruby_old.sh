#!/bin/bash

INSTALL_DIR=/opt/ruby-1.8.7
RUBY_TAG=origin/ruby_1_8_7
GEM_TAG=v1.3.7
RUBY_VERSION=1.8.7

source _setup_ruby.sh

rm -rf $INSTALL_DIR > /dev/null

cd $RUBY_SRC
autoconf && CC=gcc34 CXX=g++34 ./configure --prefix=/opt/ruby-1.8.7
make clean && make && make install

cd $GEM_SRC
$INSTALL_DIR/bin/ruby setup.rb 

$INSTALL_DIR/bin/gem install bundler08 thin rdoc \
                             net-ssh-gateway net-ssh net-sftp net-scp

$INSTALL_DIR/bin/gem install rake --version 0.9.2.2

cd $START_DIR && ./ruby_aes.sh

cd $START_DIR && source _fix_ruby_src_owner.sh

# install passenger-nginx

export PATH=$INSTALL_DIR/bin:$PATH

gem install passenger --version 2.2.9 --no-ri --no-rdoc
passenger-install-nginx-module --auto --auto-download --prefix=/opt/nginx --extra-configure-flags='--with-cc-opt=-Wno-error'


