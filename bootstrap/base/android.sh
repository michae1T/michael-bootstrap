#!/bin/bash

source `dirname $0`/../_environment.sh

write_env_script 'android' \
  "  export ANDROID_HOME=\$HOME/opt/android/android-sdk-linux\n
     export ANDROID_BUILD_VERSION=22.0.1\n
     export PATH=\$ANDROID_HOME/tools:\$ANDROID_HOME/platform-tools:\$ANDROID_HOME/build-tools/\$ANDROID_BUILD_VERSION:\$PATH\n
  " \
  "adb version"
