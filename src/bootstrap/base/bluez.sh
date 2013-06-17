#!/bin/bash

source `dirname $0`/../_environment.sh

LINUX_PROJECT_DIR=$USER_HOME/src/linux

checkout_repo "$LINUX_PROJECT_DIR" "bluez" \
              "git://git.kernel.org/pub/scm/bluetooth/bluez.git" \
              "master"

cd $USER_HOME/src/linux/bluez
autoreconf --install

./configure --prefix=/usr --mandir=/usr/share/man --sysconfdir=/etc --localstatedir=/var \
            --enable-bccmd \
            --enable-dfutool \
            --enable-dund \
            --enable-hid2hci \
            --enable-hidd \
            --enable-pand \
            --enable-tools \
            --enable-wiimote

make && make install
chown -R $USER_STAT .
