#!/bin/bash

source `dirname $0`/../_environment.sh

SBT_VER=1.10.5
SCALA_VER=3.5.2

curl "https://github.com/sbt/sbt/releases/download/v${SBT_VER}/sbt-${SBT_VER}.zip" -L > sbt-${SBT_VER}.zip
unzip -o sbt-${SBT_VER}.zip
rm sbt-${SBT_VER}.zip
rm -rf /opt/sbt-$SBT_VER
mv sbt /opt/sbt-$SBT_VER

wget "https://github.com/scala/scala3/releases/download/${SCALA_VER}/scala3-${SCALA_VER}.tar.gz"
tar -xzf scala3-$SCALA_VER.tar.gz
rm scala3-$SCALA_VER.tar.gz
rm -rf /opt/scala-$SCALA_VER
mv scala3-$SCALA_VER /opt/scala-$SCALA_VER

# predownload sbt runtimes
su - $USER_OWNER -c "/opt/sbt-$SBT_VER/bin/sbt sbtVersion"

write_env_script 'scala-new' \
  "export PATH=/opt/scala-$SCALA_VER/bin:/opt/sbt-$SBT_VER/bin:\$PATH" \
  "scala -version\nwhich sbt"

