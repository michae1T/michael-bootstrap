#!/bin/bash

source `dirname $0`/_environment.sh

mkdir -p $DEFAULT_CONFIG_DIR

[ ! -d $DEFAULT_CONFIG_DIR/public ]  && git clone git@github.com:michae1T/michael-configs-public.git $DEFAULT_CONFIG_DIR/public;
[ ! -d $DEFAULT_CONFIG_DIR/private ] && git clone git@github.com:michae1T/michael-configs-private.git $DEFAULT_CONFIG_DIR/private;

cd $DEFAULT_CONFIG_DIR/private
make clean && git pull && make decrypt

