#!/bin/bash

source `dirname $0`/../_environment.sh

su - $USER_OWNER -c "git config --global color.ui auto"

# VIM scala highlighting
mkdir -p ~/.vim/{ftdetect,indent,syntax} && for d in ftdetect indent syntax ; do wget --no-check-certificate -O ~/.vim/$d/scala.vim https://raw.github.com/scala/scala-dist/master/tool-support/src/vim/$d/scala.vim; done


