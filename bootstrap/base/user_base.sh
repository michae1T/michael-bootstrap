#!/bin/bash

source `dirname $0`/../_environment.sh

checkout_repo $USER_HOME/src/console/vim-plugins file-line https://github.com/bogado/file-line.git origin/master
checkout_repo $USER_HOME/src/console/vim-plugins scala-vim-support https://github.com/rosstimson/scala-vim-support.git 89ccea89f35ad7d0274167810469eb7092ecc1d5

CMDS='
  # full featured vim mode including colours
  git config --global core.editor vim
  git config --global color.ui auto; 
  git config --global push.default matching;
  git config --global core.excludesfile ~/.gitignore

  cd ~/src/console/vim-plugins/scala-vim-support

  if [ -n "`git show HEAD | grep 89ccea89f35ad7d0274167810469eb7092ecc1d5`" ] ; then
    mkdir -p ~/.vim/{ftdetect,indent,syntax};
    for d in ftdetect indent syntax ; do 
      ln -sf ~/src/console/vim-plugins/scala-vim-support/$d/scala.vim ~/.vim/$d/scala.vim 
    done;
  else
    echo "error: could not find good vim-plugins"
    exit 1
  fi;

  mkdir -p ~/.vim/plugin

  LINE_PLUGIN=~/src/console/vim-plugins/file-line/plugin/file_line.vim
  if [ -n "`sha256sum $LINE_PLUGIN | grep 3885e660f0a3d0ba7313788b5480bdb7544723fa4f34fc0db0ddafb190375df5`" ] ;
    then ln -sf $LINE_PLUGIN ~/.vim/plugin/
  fi;
'
 
if [ -d "$DEFAULT_CONFIG_DIR" ] ; then

  CMDS2="
    ln -sf $DEFAULT_CONFIG_DIR/public/vim/vimrc ~/.vimrc ;
    ln -sf $DEFAULT_CONFIG_DIR/public/screen/screenrc ~/.screenrc ;
    ln -sf $DEFAULT_CONFIG_DIR/public/tmux/tmux ~/.tmux ;
    ln -sf $DEFAULT_CONFIG_DIR/public/git/gitignore ~/.gitignore ;
  "

  CMDS="$CMDS $CMDS2"

fi;

if [ `id -u` = "0" ] ;
  then su - $USER_OWNER -c "$CMDS"
  else bash -c "$CMDS"
fi;

