#!/bin/bash

# build submodule requires /usr/bin/ruby -> 1.8.7
mv /usr/bin/ruby /usr/bin/ruby.bak > /dev/null
ln -s /opt/ruby-1.8.7/bin/ruby /usr/bin/ruby

# link for passenger
mkdir -p /opt/local/bin
mv /opt/local/bin/ruby /opt/local/bin/ruby.bak > /dev/null
ln -s /opt/ruby-1.8.7/bin/ruby /opt/local/bin

rm  /opt/ruby-1.8.7/lib/ruby/gems/1.8/gems/ > /dev/null
ln -s /opt/ruby-1.8.7/lib/ruby/gems/1.8/gems/ /web/gems
