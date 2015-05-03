#!/bin/bash

source `dirname $0`/../_environment.sh

if [ -z "$PREFIX" ] ; then
  require_root
  PREFIX=/opt/scripts/common_tools
  rm -rf $PREFIX
fi;

mkdir -p $PREFIX

cp $SCRIPTS_DIR/common-tools/* $PREFIX

