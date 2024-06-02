#!/bin/bash

source `dirname $0`/../_environment.sh

if [ -z "$PREFIX" ] ; then
  require_root
  PREFIX=/opt
fi;

mkdir -p $PREFIX/bin

CONSOLE_SRC=$USER_HOME/src/console

/usr/sbin/groupadd -g 84 -r -f screen

yum_safe install -y pam-devel ncurses-devel

checkout_repo "$CONSOLE_SRC" "screen" \
              "git://git.savannah.gnu.org/screen.git" \
              "master"

cd $CONSOLE_SRC/screen/src
./autogen.sh && ./configure --prefix=$PREFIX && make && make install \
             && chown root:screen /opt/bin/screen && chmod g+s /opt/bin/screen

echo "D /var/run/screen 0775 nobody screen -" > /etc/tmpfiles.d/screen.conf
systemd-tmpfiles --create screen.conf


