#!/bin/bash

source `dirname $0`/../_environment.sh

RUBY_INSTALL_DIR=/opt/ruby-1.9.3
RUBY_TAG=origin/ruby_1_9_3
GEM_TAG=origin/1.8
RUBY_VERSION=1.9.3
ENV_NAME=ruby-new

source $SHARED/_setup_ruby.sh

