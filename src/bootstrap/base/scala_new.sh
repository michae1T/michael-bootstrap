#!/bin/bash

source `dirname $0`/../_environment.sh

SBT_VER=0.13.0
wget "http://repo.scala-sbt.org/scalasbt/sbt-native-packages/org/scala-sbt/sbt/$SBT_VER/sbt.zip"
unzip -o sbt.zip
rm sbt.zip
rm -rf /opt/sbt-$SBT_VER
mv sbt /opt/sbt-$SBT_VER

SCALA_VER=2.10.3
wget "http://www.scala-lang.org/files/archive/scala-$SCALA_VER.tgz"
tar -xzf scala-$SCALA_VER.tgz
rm scala-$SCALA_VER.tgz
rm -rf /opt/scala-$SCALA_VER
mv scala-$SCALA_VER /opt

ENV_RUNFILE=$USER_HOME/bin/set-scala-new-env
cat > $ENV_RUNFILE <<EOF
#!/bin/bash

export PATH=/opt/scala-$SCALA_VER/bin:/opt/sbt-$SBT_VER/bin:\$PATH

if [ -z "\$NO_VERSION" ] ; then
  scala -version
  sbt --version | grep version
fi;

if [ -z "\$NO_SHELL" ] ;
 then bash
fi;

EOF

chmod +x $ENV_RUNFILE
chown $USER_STAT $ENV_RUNFILE

