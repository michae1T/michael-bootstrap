#!/bin/bash

yum -y install ruby

rm -rf /opt/ruby-1.8.7

cd /opt
mkdir src
cd src

if [ -d /opt/src/ruby ]
then cd /opt/src/ruby && git add . && git reset --hard && git fetch
else git clone https://github.com/ruby/ruby.git
fi

if [ -d /opt/src/rubygems ]
then cd /opt/src/rubygems && git add . && git reset --hard && git fetch
else git clone https://github.com/rubygems/rubygems.git
fi

cd /opt/src/ruby

git checkout origin/ruby_1_9_3 && autoconf
./configure --prefix=/opt/ruby-1.9.3

make clean && make && make install

cd /opt/src/rubygems
git checkout origin/1.8
/opt/ruby-1.9.3/bin/ruby setup.rb 

yum -y remove ruby


