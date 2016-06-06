#!/bin/bash

source `dirname $0`/../_environment.sh

SBT_VER=0.13.11
SCALA_VER=2.11.8
PLAY_VER=1.3.7

curl "https://dl.bintray.com/sbt/native-packages/sbt/$SBT_VER/sbt-$SBT_VER.zip" -L > sbt-${SBT_VER}.zip
unzip -o sbt-${SBT_VER}.zip
rm sbt-${SBT_VER}.zip
rm -rf /opt/sbt-$SBT_VER
mv sbt /opt/sbt-$SBT_VER

wget "http://www.scala-lang.org/files/archive/scala-$SCALA_VER.tgz"
tar -xzf scala-$SCALA_VER.tgz
rm scala-$SCALA_VER.tgz
rm -rf /opt/scala-$SCALA_VER
mv scala-$SCALA_VER /opt

wget "https://downloads.typesafe.com/typesafe-activator/$PLAY_VER/typesafe-activator-$PLAY_VER-minimal.zip"
unzip -o typesafe-activator-$PLAY_VER-minimal.zip
rm typesafe-activator-$PLAY_VER-minimal.zip
rm -rf /opt/play-$PLAY_VER
mv activator-$PLAY_VER-minimal /opt/play-$PLAY_VER
chmod o+x /opt/play-$PLAY_VER/activator

# predownload sbt runtimes
su - $USER_OWNER -c "/opt/sbt-$SBT_VER/bin/sbt sbtVersion"

write_env_script 'scala-new' \
  "export PATH=/opt/scala-$SCALA_VER/bin:/opt/sbt-$SBT_VER/bin:/opt/play-$PLAY_VER:\$PATH" \
  "scala -version\nwhich sbt"

