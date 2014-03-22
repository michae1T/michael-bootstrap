#!/bin/bash

# wip

source `dirname $0`/../_environment.sh

yum_safe -y install lzma* gmp*

VER=1.9.3

cd /tmp
wget 'http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-$VER.tar.bz2'
tar xfj crosstool-ng-$VER.tar.bz2 
cd crosstool-ng-$VER

build() {
  ./configure --prefix=/opt/crosstool && make && make install && echo '### success ###'
}

SUCCESS=`build()` | grep '###'

if [ -z "$SUCCESS" ] ; then
  echo "build failed"
  exit 1
fi;

PATH=/opt/crosstool/bin:$PATH

rm -rf /tmp/cross-env
mkdir /tmp/cross-env
cd /tmp/cross-env
ct-ng oldconfig $USER_HOME/src/pi/crosstool_config
ct-ng build

