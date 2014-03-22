#!/bin/bash

MONGO_HOME=/home/mongodb
MONGO_ESC='\/home\/mongodb'

rm -rf $MONGO_HOME
mkdir $MONGO_HOME
chown mongodb $MONGO_HOME
chcon -R -t mongod_var_lib_t -v $MONGO_HOME
semanage fcontext -a -t mongod_var_lib_t "$MONGO_HOME(/.*)?"

sed "s/\/var\/lib\/mongodb/$MONGO_ESC/g" /etc/mongodb.conf > /etc/mongodb.conf.new
mv -f /etc/mongodb.conf /etc/mongodb.conf.bak
mv /etc/mongodb.conf.new /etc/mongodb.conf
