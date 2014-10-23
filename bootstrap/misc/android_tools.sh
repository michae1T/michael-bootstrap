#!/bin/bash

source `dirname $0`/../_environment.sh

checkout_repo "$USER_HOME/src" "Heimdall" \
              "git://github.com/Benjamin-Dobell/Heimdall.git" \
              "master"

cd $USER_HOME/src/Heimdall/libpit
./autogen.sh
./configure
make
cd ../heimdall
./autogen.sh
./configure
make
cd ../heimdall-frontend/
qmake-qt4 heimdall-frontend.pro
make
