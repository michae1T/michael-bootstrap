#!/bin/bash

source `dirname $0`/../_environment.sh

checkout_repo $USER_HOME/src/console/vim-plugins file-line https://github.com/bogado/file-line.git origin/master
checkout_repo $USER_HOME/src/console/vim-plugins scala-vim-support https://github.com/rosstimson/scala-vim-support.git

CMDS='
  # full featured vim mode including colours
  git config --global core.editor vim
  git config --global color.ui auto; 
  git config --global push.default matching;

  if [ -n "`git show HEAD | grep 89ccea89f35ad7d0274167810469eb7092ecc1d5`" ] ; then
    mkdir -p ~/.vim/{ftdetect,indent,syntax};
    for d in ftdetect indent syntax ; do 
      ln -sf ~/src/console/vim-plugins/scala-vim-support/$d/scala.vim ~/.vim/$d/scala.vim 
    done;
  fi;

  mkdir -p ~/.vim/plugin

  LINE_PLUGIN=~/src/console/vim-plugins/file-line/plugin/file_line.vim
  if [ -n "`sha256sum $LINE_PLUGIN | grep 9cd8216622b283c3d262dbb7286e3de48ad0244e50bf8a67861bdbf82d5b8d29`" ] ;
    then ln -sf $LINE_PLUGIN ~/.vim/plugin/
  fi;
'
 
if [ -d "$DEFAULT_CONFIG_DIR" ] ; then

  CMDS2="
    ln -sf $DEFAULT_CONFIG_DIR/public/vim/vimrc ~/.vimrc ;
    ln -sf $DEFAULT_CONFIG_DIR/public/screen/screenrc ~/.screenrc ;
    ln -sf $DEFAULT_CONFIG_DIR/public/tmux/tmux ~/.tmux ;
  "

  CMDS="$CMDS $CMDS2"

fi;

if [ `id -u` = "0" ] ;
  then su - $USER_OWNER -c "$CMDS"
  else bash -c "$CMDS"
fi;

