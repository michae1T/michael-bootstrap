#!/bin/bash

source `dirname $0`/../_environment.sh

MARKER="### workstation linkage ###"

if [ -d "$DEFAULT_CONFIG_DIR" ] ; then

  if ! grep -q "$MARKER" $USER_HOME/.bashrc ; then
    echo -e "\n$MARKER\nsource $DEFAULT_CONFIG_DIR/public/bash_desktop/bashrc" >> $USER_HOME/.bashrc
    echo -e "\n$MARKER\nsource $DEFAULT_CONFIG_DIR/private/content/bash_desktop/bash_profile" >> $USER_HOME/.bash_profile
  fi;

fi;
