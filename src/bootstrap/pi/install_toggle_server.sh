#!/bin/bash

source `dirname $0`/../_environment.sh

SCALA_ENV=$USER_HOME/bin/set-scala-new-env
SOURCE_DIR=$USER_HOME/src/scala/toggle-server
RUN_FILE=/usr/lib/systemd/system/toggle-server.service
RUN_DIR=/var/run/toggle-server

if [ ! -e "$SCALA_ENV" ] ; then
  echo "scala build environment not ready... try $USER_HOME/src/bootstrap/base/scala_new.sh"
  exit 1
fi;

NO_SHELL=1 source $SCALA_ENV

cd $SOURCE_DIR
JAR_PATH=`sbt ";clean;assembly" | grep toggle-server.jar | awk '{ print $3 }'`
chown -R $USER_STAT .
cd $START_DIR

if [ -z "$JAR_PATH" ] ; then
  echo "build failed"
  exit 1
fi

echo "build success"

mkdir -p /opt/server/
cp $JAR_PATH /opt/server

cat > $RUN_FILE << EOF
[Unit]
Description=Interface to touch tmp files via http
After=syslog.target local-fs.target network.target

[Service]
User=nobody
Group=nobody
Type=simple
ExecStart=/usr/bin/java -jar /opt/server/toggle-server.jar

[Install]
WantedBy=multi-user.target
EOF

chown root:root $RUN_FILE
chmod 644 $RUN_FILE

systemctl daemon-reload
systemctl enable toggle-server.service
systemctl restart toggle-server.service

firewall-cmd --permanent --add-port=6060/tcp

