#!/bin/bash

source `dirname $0`/../_environment.sh

LINUX_PROJECT_DIR=$USER_HOME/src/linux

checkout_repo "$LINUX_PROJECT_DIR" "linux" \
              "git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git" \
              "master"

checkout_repo "$LINUX_PROJECT_DIR" "linux-stable" \
              "git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git" \
              "master"

checkout_repo "$LINUX_PROJECT_DIR" "linux-next" \
              "git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git" \
              "master"

if [ -e linux/.config ] ; then mv -f linux/.config linux/.config.bak; fi;
if [ -e linux-next/.config ] ; then mv -f linux-next/.config linux-next/.config.bak; fi;
if [ -e linux-stable/.config ] ; then mv -f linux-stable/.config linux-stable/.config.bak; fi;

ln config/linux-main.config linux/.config > /dev/null 2>&1
ln config/linux-stable.config linux-stable/.config > /dev/null 2>&1
ln config/linux-next.config linux-next/.config > /dev/null 2>&1

