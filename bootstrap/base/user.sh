#!/bin/bash

source `dirname $0`/../_environment.sh


CMDS='git config --global color.ui auto; git config --global push.default matching;mkdir -p ~/.vim/{ftdetect,indent,syntax} && for d in ftdetect indent syntax ; do wget --no-check-certificate -O ~/.vim/$d/scala.vim https://raw.githubusercontent.com/rosstimson/scala-vim-support/master/$d/scala.vim; done; echo ":set background=light" >> ~/.vimrc'

if [ `id -u` = "0" ] ;
  then su - $USER_OWNER -c "$CMDS"
  else bash -c "$CMDS"
fi;
