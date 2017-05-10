#!/bin/bash

source `dirname $0`/../_environment.sh

yum_safe install qt5-qttools-* libusb*

ANDROID_SRC=$USER_HOME/src/android
ANDROID_DIR=$USER_HOME/opt/android

mkdir -p $ANDROID_SRC && chown $USER_STAT $ANDROID_SRC
mkdir -p $ANDROID_DIR && chown $USER_STAT $ANDROID_DIR

checkout_repo "$ANDROID_SRC" "Heimdall" \
              "git://github.com/Benjamin-Dobell/Heimdall.git" \
              "master"

HEIMDALL_INSTALL=$ANDROID_DIR/heimdall

cd $ANDROID_SRC/Heimdall
cmake -DCMAKE_BUILD_TYPE=Release
make
chown -R $USER_STAT .
[ ! -d $HEIMDALL_INSTALL ] && mkdir $HEIMDALL_INSTALL && chown $USER_STAT $HEIMDALL_INSTALL
cp -f bin/* $HEIMDALL_INSTALL

write_env_script 'android' \
  "  export ANDROID_HOME=\$HOME/opt/android/android-sdk-linux\n
     export ANDROID_BUILD_VERSION=25.0.0\n
     export PATH=\$ANDROID_HOME/tools:\$ANDROID_HOME/platform-tools:\$ANDROID_HOME/build-tools/\$ANDROID_BUILD_VERSION:\$PATH\n
     export PATH=$ANDROID_DIR/genymotion:$HEIMDALL_INSTALL:\$PATH\n
  " \
  "adb version"
