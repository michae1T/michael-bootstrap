#!/bin/bash

source `dirname $0`/../_environment.sh

yum -y update

yum -y groupinstall 'Development Tools'

yum_safe -y install git git-daemon \
               mongodb* postgresql postgresql-server \
               java-1.7*openjdk* scala \
               maven maven-ant-plugin ant apache-ivy \
               ruby \
               puppet* rabbitmq* \
               perl-JSON perl-Module-Load \
               ImageMagick-perl ImageMagick-devel \
               stunnel \
               tk* tcl* \
               wget curl lynx telnet nc bind-utils \
               ack pcre \
               gdbm-devel openssl* \
               openssh* \
               compat-libstd* compat-gcc* compat-readline* \
               snakeyaml libyaml* perl-YAML* \
               patch readline* \
               zlib zlib-devel libffi-devel \
               bzip2 sqlite sqlite-devel \
               libxslt* libxml2 libxml2-devel \
               libpng-* libpng12 pangox-compat \
               fuse-encfs \
               tmux screen vim-enhanced \
               ddclient nodejs \
               cronie \
               openvpn* \
               nfs-utils \
               ntfs-3g ntfsprogs \
               libusb-devel libusb-static systemd-devel libical-devel

yum clean all


