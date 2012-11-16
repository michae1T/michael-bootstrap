#!/bin/bash

wget http://aescrypt.sourceforge.net/aes-rb-0.1.0.tar.gz
tar -xvf aes-rb-0.1.0.tar.gz
cd aes-rb-0.1.0
/opt/ruby-1.8.7/bin/ruby extconf.rb && make && make install
cd .. && rm -rf aes-rb-0.1.0*

