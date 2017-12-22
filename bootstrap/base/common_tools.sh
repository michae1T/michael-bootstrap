#!/bin/bash

source `dirname $0`/../_environment.sh

if [ -z "$PREFIX" ] ; then
  require_root
  PREFIX=/opt/scripts/common_tools
  rm -rf $PREFIX
fi;

mkdir -p $PREFIX

cp $SCRIPTS_DIR/common-tools/* $PREFIX

checkout_repo "$USER_HOME/src" "michael-scripts" \
              "https://github.com/michae1T/michael-scripts.git" \
              "master"

cp $USER_HOME/src/michael-scripts/vif $PREFIX

curl -L https://raw.githubusercontent.com/gilt/kms-s3/master/install | /bin/bash

