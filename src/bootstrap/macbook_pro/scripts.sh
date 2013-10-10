#!/bin/bash

source `dirname $0`/../_environment.sh

config_sys_sudo $USER_HOME/src/scripts/macbook-pro

make_sys_sudo_redirect 'screen-max-dim'
make_sys_sudo_redirect 'slow-gfx'

