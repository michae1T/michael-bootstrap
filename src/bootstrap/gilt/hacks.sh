#!/bin/bash

source `dirname $0`/../_environment.sh

backup_from_usr() {
  if [ -e /usr/bin/$1 ] ; then
    if grep -q  'redirect me' /usr/bin/$1  ; then
       echo "not backing up sys $1"
     else
       cp /usr/bin/$1 /usr/bin/$1.sys > /dev/null 2>&1
    fi;
    mv -f /usr/bin/$1 /usr/bin/$1.bak
  fi;
}

# almost every project is hardcoded to /web
mkdir -p $USER_HOME/src/gilt
ln -s $USER_HOME/src/gilt /web > /dev/null 2>&1

rm -rf /opt/scripts/gilt
mkdir -p /opt/scripts/gilt
cp $USER_HOME/src/scripts/gilt/* /opt/scripts/gilt/
chown root:root /opt/scripts/gilt/*

# build submodule hardcoded requirement at /usr/bin/ruby -> 1.8.7
#  redirect to sys ruby
backup_from_usr ruby
ln -s /opt/scripts/gilt/ruby-proxy.sh /usr/bin/ruby > /dev/null 2>&1

# build submodule hardcoded requirement at /usr/bin/mvn
#  redirect to sys mvn
backup_from_usr mvn
ln -s /opt/scripts/gilt/mvn-proxy.sh /usr/bin/mvn > /dev/null 2>&1

# link ruby exec for passenger, hardcoded in tools
#  redirecto to sysruby
mkdir -p /opt/local/bin
mv /opt/local/bin/ruby /opt/local/bin/ruby.bak > /dev/null 2>&1
ln -s /opt/scripts/gilt/ruby-proxy.sh /opt/local/bin > /dev/null 2>&1

# link gem folder for passenger, hardcoded in tools
rm  /web/gems > /dev/null 2>&1
ln -s /opt/ruby-1.8.7/lib/ruby/gems/1.8/gems/ /web/gems > /dev/null 2>&1
