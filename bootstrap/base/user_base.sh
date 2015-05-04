#!/bin/bash

source `dirname $0`/../_environment.sh

CMDS='
  # full featured vim mode including colours
  git config --global core.editor vim
  git config --global color.ui auto; 
  git config --global push.default matching;

  mkdir -p ~/.vim/{ftdetect,indent,syntax};
  for d in ftdetect indent syntax ; do 
    wget --no-check-certificate -O ~/.vim/$d/scala.vim https://raw.githubusercontent.com/rosstimson/scala-vim-support/master/$d/scala.vim; 
  done;
'
 
if [ -d "$DEFAULT_CONFIG_DIR" ] ; then

  CMDS2="
    [ ! -f "~/.vimrc"    ] && ln -s $DEFAULT_CONFIG_DIR/public/vim/vimrc ~/.vimrc ;
    [ ! -f "~/.screenrc" ] && ln -s $DEFAULT_CONFIG_DIR/public/screen/screenrc ~/.screenrc ;
    [ ! -f "~/.tmux"     ] && ln -s $DEFAULT_CONFIG_DIR/public/tmux/tmux ~/.tmux ;
  "

  CMDS="$CMDS $CMDS2"

fi;

if [ `id -u` = "0" ] ;
  then su - $USER_OWNER -c "$CMDS"
  else bash -c "$CMDS"
fi;
