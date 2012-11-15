#!/bin/bash

mkdir -p ~/src/linux
cd ~/src/linux

git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git clone git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git

ln config/linux-main.conf linux/.config
ln config/linux-stable.conf linux-stable/.config
ln config/linux-next.conf linux-next/.config

