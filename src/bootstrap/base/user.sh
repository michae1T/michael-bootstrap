#!/bin/bash

source `dirname $0`/../_environment.sh

su - $USER_OWNER -c "git config --global color.ui auto"

