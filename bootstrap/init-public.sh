#!/bin/bash

source `dirname $0`/_environment.sh

mkdir -p $DEFAULT_CONFIG_DIR

[ ! -d $DEFAULT_CONFIG_DIR/public ] && git clone https://github.com/michae1T/michael-configs-public.git $DEFAULT_CONFIG_DIR/public;
