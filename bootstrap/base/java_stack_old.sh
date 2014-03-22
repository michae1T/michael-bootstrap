#!/bin/bash

cd /opt/

rm -rf apache-ant* apache-ivy* apache-maven* > /dev/null 2>&1

wget http://archive.apache.org/dist/ant/binaries/apache-ant-1.8.2-bin.tar.gz
tar -xvf apache-ant-1.8.2-bin.tar.gz
rm apache-ant-1.8.2-bin.tar.gz

wget http://www.us.apache.org/dist//ant/ivy/2.3.0-rc2/apache-ivy-2.3.0-rc2-bin.tar.gz
tar -xvf apache-ivy-2.3.0-rc2-bin.tar.gz
rm apache-ivy-2.3.0-rc2-bin.tar.gz

ln -s /opt/apache-ivy-2.3.0-rc2/ivy-2.3.0-rc2.jar /opt/apache-ant-1.8.2/lib/ivy.jar

wget http://www.us.apache.org/dist/maven/maven-3/3.0.4/binaries/apache-maven-3.0.4-bin.tar.gz
tar -xvf apache-maven-3.0.4-bin.tar.gz
rm apache-maven-3.0.4-bin.tar.gz

