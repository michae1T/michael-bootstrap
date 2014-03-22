#!/bin/bash

source `dirname $0`/../_environment.sh

config_sys_sudo $SCRIPTS_DIR/macbook-pro

make_sys_sudo_redirect 'slow-gfx'
make_sys_sudo_redirect 'screen-max-dim-2'
make_sys_sudo_redirect 'screen-max-dim'
make_sys_sudo_redirect 'slow-gfx'

