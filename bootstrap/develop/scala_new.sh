#!/bin/bash

source `dirname $0`/../_environment.sh

SBT_VER=1.2.6
SCALA_VER=2.12.7

curl "https://github.com/sbt/sbt/releases/download/v${SBT_VER}/sbt-${SBT_VER}.zip" -L > sbt-${SBT_VER}.zip
unzip -o sbt-${SBT_VER}.zip
rm sbt-${SBT_VER}.zip
rm -rf /opt/sbt-$SBT_VER
mv sbt /opt/sbt-$SBT_VER

wget "https://downloads.lightbend.com/scala/${SCALA_VER}/scala-${SCALA_VER}.tgz"
tar -xzf scala-$SCALA_VER.tgz
rm scala-$SCALA_VER.tgz
rm -rf /opt/scala-$SCALA_VER
mv scala-$SCALA_VER /opt

# predownload sbt runtimes
su - $USER_OWNER -c "/opt/sbt-$SBT_VER/bin/sbt sbtVersion"

write_env_script 'scala-new' \
  "export PATH=/opt/scala-$SCALA_VER/bin:/opt/sbt-$SBT_VER/bin:\$PATH" \
  "scala -version\nwhich sbt"

