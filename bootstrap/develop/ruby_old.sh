#!/bin/bash

source `dirname $0`/../_environment.sh

RUBY_INSTALL_DIR=/opt/ruby-1.8.7
RUBY_TAG=origin/ruby_1_8_7
GEM_TAG=v1.3.7
RUBY_VERSION=1.8.7
ENV_NAME=ruby-old

export CC=gcc34
export CXX=g++34

source develop/_setup_ruby.sh


