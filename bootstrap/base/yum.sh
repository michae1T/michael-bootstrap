#!/bin/bash

source `dirname $0`/../_environment.sh

yum_safe update

yum_safe groupinstall 'Development Tools'

yum_safe install git \
               java-1.8*openjdk*headless \
               maven maven-ant-plugin ant apache-ivy \
               nginx \
               irssi \
               perl perl-CPAN perl-Module-Load \
               python3 python3-pip \
               wget curl lynx nmap \
               telnet nc bind-utils iputils iproute net-tools traceroute \
               ack fdupes pcre \
               sysstat strace \
               tar gzip zip unzip \
               uuid \
               bash-completion \
               gdbm-devel openssl* openssh* \
               compat-readline* \
               snakeyaml libyaml* \
               cmake automake libtool rpm-build \
               patch readline* gettext* intltool \
               autoconf byacc bison \
               zlib zlib-devel libffi-devel \
               bzip2 sqlite sqlite-devel \
               libxslt* libxml2 libxml2-devel \
               libpng-* libpng12 pangox-compat \
               nodejs jq yajl \
               cronie \
               nfs-utils \
               kernel-devel*

