#!/bin/bash

source `dirname $0`/../_environment.sh

yum -y update

yum -y groupinstall 'Development Tools'

yum_safe -y install git git-daemon \
               mongodb* postgresql postgresql-server postgresql-contrib \
               java-1.8*openjdk* scala maven \
               maven maven-ant-plugin ant apache-ivy \
               ruby nginx thttpd \
               puppet* rabbitmq* \
               perl-JSON perl-Module-Load \
               ImageMagick-perl ImageMagick-devel \
               stunnel \
               wget curl lynx telnet nc bind-utils \
               ack fdupes pcre \
               gdbm-devel openssl* \
               openssh* \
               compat-libstd* compat-gcc* compat-readline* \
               snakeyaml libyaml* perl-YAML* \
               patch readline* jq \
               autoconf byacc bison \
               zlib zlib-devel libffi-devel \
               bzip2 sqlite sqlite-devel \
               libxslt* libxml2 libxml2-devel \
               libpng-* libpng12 pangox-compat \
               fuse-encfs \
               tmux screen vim-enhanced \
               ddclient nodejs npm \
               cronie \
               openvpn* \
               nfs-utils \
               ntfs-3g ntfsprogs \
               kernel-devel* \
               libusb-devel libusb-static systemd-devel libical-devel

yum_safe clean all


