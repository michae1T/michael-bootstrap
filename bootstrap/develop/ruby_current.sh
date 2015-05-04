#!/bin/bash

source `dirname $0`/../_environment.sh

RUBY_INSTALL_DIR=/opt/ruby-2.2.0
RUBY_TAG=origin/ruby_2_2
GEM_TAG=origin/1.8
RUBY_VERSION=2.2.0
ENV_NAME=ruby-new

source develop/_setup_ruby.sh

