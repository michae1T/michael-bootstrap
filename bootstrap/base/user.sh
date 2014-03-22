#!/bin/bash

source `dirname $0`/../_environment.sh


CMDS="git config --global color.ui auto; mkdir -p ~/.vim/{ftdetect,indent,syntax} && for d in ftdetect indent syntax ; do wget --no-check-certificate -O ~/.vim/$d/scala.vim https://raw.github.com/scala/scala-dist/master/tool-support/src/vim/$d/scala.vim; done"

if [ `id -u` = "0" ] ;
  then su - $USER_OWNER -c "$CMDS"
  else bash -c "$CMDS"
fi;
