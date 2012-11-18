#!/bin/bash

source `dirname $0`/../_environment.sh

# almost every project is hardcoded to /web
mkdir -p $USER_HOME/src/gilt
ln -s $USER_HOME/src/gilt /web > /dev/null 2>&1

# build submodule hardcoded requirement at /usr/bin/ruby -> 1.8.7
mv /usr/bin/ruby /usr/bin/ruby.bak > /dev/null 2>&1
ln -s /opt/ruby-1.8.7/bin/ruby /usr/bin/ruby > /dev/null 2>&1

# link ruby exec for passenger, hardcoded in tools
mkdir -p /opt/local/bin
mv /opt/local/bin/ruby /opt/local/bin/ruby.bak > /dev/null 2>&1
ln -s /opt/ruby-1.8.7/bin/ruby /opt/local/bin > /dev/null 2>&1

# link gem folder for passenger, hardcoded in tools
rm  /web/gems > /dev/null 2>&1
ln -s /opt/ruby-1.8.7/lib/ruby/gems/1.8/gems/ /web/gems > /dev/null 2>&1

