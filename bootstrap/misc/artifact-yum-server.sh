#!/bin/bash

VER=2.0.1

cd /tmp
rm -rf apache-archiva*
wget http://ftp.cixug.es/apache/archiva/$VER/binaries/apache-archiva-$VER-bin.zip
unzip apache-archiva-$VER-bin.zip
rm -rf /opt/apache-archiva.bak
mv /opt/apache-archiva /opt/apache-archiva.bak
mv apache-archiva-$VER /opt/apache-archiva
chown root:root -R /opt/apache-archiva
