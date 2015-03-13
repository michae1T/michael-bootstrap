#!/bin/bash

source `dirname $0`/../_environment.sh

if [ -z "$PREFIX" ] ; then
  require_root
  PREFIX=/opt/bin
fi;

mkdir -p $PREFIX

cp $SCRIPTS_DIR/docker-env/* $PREFIX
