#!/bin/bash

source `dirname $0`/../_environment.sh

mkdir -p $USER_HOME/src/linux
cd $USER_HOME/src/linux

if [ ! -d linux ] ; then        git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git; fi;
if [ ! -d linux-next ] ; then   git clone git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git; fi;
if [ ! -d linux-stable ] ; then git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git; fi;

if [ -e linux/.config ] ; then mv -f linux/.config linux/.config.bak; fi;
if [ -e linux-next/.config ] ; then mv -f linux-next/.config linux-next/.config.bak; fi;
if [ -e linux-stable/.config ] ; then mv -f linux-stable/.config linux-stable/.config.bak; fi;

ln config/linux-main.config linux/.config > /dev/null 2>&1
ln config/linux-stable.config linux-stable/.config > /dev/null 2>&1
ln config/linux-next.config linux-next/.config > /dev/null 2>&1

chown -R $USER_STAT linux
chown -R $USER_STAT linux-next
chown -R $USER_STAT linux-stable

