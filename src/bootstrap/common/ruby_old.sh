#!/bin/bash

yum -y install ruby-devel

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

git checkout origin/ruby_1_8_7 && autoconf
CC=gcc34 CXX=g++34 ./configure --prefix=/opt/ruby-1.8.7

make clean && make

cd ext/dl
ruby mkcallback.rb > callback.func
ruby mkcbtable.rb > cbtable.func
cd /opt/src/ruby

make && make install

cd /opt/src/rubygems
git checkout v1.3.7
/opt/ruby-1.8.7/bin/ruby setup.rb 

/opt/ruby-1.8.7/bin/gem install bundler08

ln -s /opt/ruby-1.8.7/bin/ruby /usr/local/bin/ruby

yum -y remove ruby-devel ruby*

