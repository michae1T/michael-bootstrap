#!/bin/bash

source `dirname $0`/../_environment.sh

SBT_VER=0.13.5
SCALA_VER=2.11.1

wget "http://repo.scala-sbt.org/scalasbt/sbt-native-packages/org/scala-sbt/sbt/$SBT_VER/sbt.zip"
unzip -o sbt.zip
rm sbt.zip
rm -rf /opt/sbt-$SBT_VER
mv sbt /opt/sbt-$SBT_VER

wget "http://www.scala-lang.org/files/archive/scala-$SCALA_VER.tgz"
tar -xzf scala-$SCALA_VER.tgz
rm scala-$SCALA_VER.tgz
rm -rf /opt/scala-$SCALA_VER
mv scala-$SCALA_VER /opt

write_env_script 'scala-new' \
  "export PATH=/opt/scala-$SCALA_VER/bin:/opt/sbt-$SBT_VER/bin:\$PATH" \
  "scala -version\nsbt --version | grep version"

