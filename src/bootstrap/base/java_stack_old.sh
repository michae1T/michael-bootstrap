#!/bin/bash

cd /opt/

rm apache-ant* apache-ivy* > /dev/null 2>&1

wget http://archive.apache.org/dist/ant/binaries/apache-ant-1.8.2-bin.tar.gz
tar -xvf apache-ant-1.8.2-bin.tar.gz
rm apache-ant-1.8.2-bin.tar.gz

wget http://www.us.apache.org/dist//ant/ivy/2.3.0-rc2/apache-ivy-2.3.0-rc2-bin.tar.gz
tar -xvf apache-ivy-2.3.0-rc2-bin.tar.gz
rm apache-ivy-2.3.0-rc2-bin.tar.gz

ln -s /opt/apache-ivy-2.3.0-rc2/ivy-2.3.0-rc2.jar /opt/apache-ant-1.8.2/lib/ivy.jar
