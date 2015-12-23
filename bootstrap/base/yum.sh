#!/bin/bash

source `dirname $0`/../_environment.sh

yum_safe update

yum_safe groupinstall 'Development Tools'

yum_safe install git git-daemon \
               mongodb* postgresql postgresql-server postgresql-contrib \
               java-1.8*openjdk*headless \
               maven maven-ant-plugin ant apache-ivy \
               docker-io docker-io-vim \
               nginx thttpd stunnel \
               irssi \
               perl perl-CPAN perl-Module-Load \
               python3 python3-pip \
               wget curl lynx nmap \
               telnet nc bind-utils iputils iproute net-tools traceroute \
               ack fdupes pcre \
               sysstat strace \
               tar gzip zip unzip \
               bash-completion \
               gdbm-devel openssl* openssh* \
               compat-libstd* compat-gcc* compat-readline* \
               snakeyaml libyaml* \
               cmake automake libtool rpm-build \
               patch readline* \
               autoconf byacc bison \
               zlib zlib-devel libffi-devel \
               bzip2 sqlite sqlite-devel \
               libxslt* libxml2 libxml2-devel \
               libpng-* libpng12 pangox-compat \
               nodejs npm jq yajl \
               cronie \
               nfs-utils \
               ntfs-3g ntfsprogs \
               kernel-devel*



