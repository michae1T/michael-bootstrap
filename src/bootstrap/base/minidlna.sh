#!/bin/bash

source `dirname $0`/../_environment.sh

CONFIG_PATH=/etc/minidlna.conf
DB_DIR=/var/cache/minidlna
RUN_FILE=/usr/lib/systemd/system/minidlna.service
RUN_DIR=/var/run/minidlna
RUN_DIR_REG='\/var\/run\/minidlna'

if [ -z "$SHARE_NAME" ] ; then
  echo "example: SHARE_NAME= SHARE_DEV= ./minidlna.sh"
  exit 1
fi;

yum -y install ffmpeg* libvorbis* libogg* libid3tag* libexif* flac*

checkout_repo "$USER_HOME/src" "minidlna-git" \
              "git://git.code.sf.net/p/minidlna/git minidlna-git" \
              "master"

cd $USER_HOME/src/minidlna-git

build() {
  ./autogen.sh && ./configure && make && make install && echo "### success ###" 
}

SUCCESS=`build | grep "###"`
if [ -z "$SUCCESS"] ; 
  then "build failed..."; exit 1;
fi;

cp minidlna.conf $CONFIG_PATH
chmod 644 $CONFIG_PATH
chown root:root $CONFIG_PATH

sed -i "s/^network_interface=.*/network_interface=$SHARE_DEV/" $CONFIG_PATH
sed -i "s/^media_dir=.*/media_dir=\/srv\/$SHARE_NAME/" $CONFIG_PATH
sed -i "s/^notify_interval=.*/notify_interval=60/" $CONFIG_PATH
sed -i "s/^friendly_name=[^\n]*/friendly_name=Linux DLNA/" $CONFIG_PATH
sed -i "s/^minissdpdsocket=.*/minissdpdsocket=$RUN_DIR_REG\/minissdpd.sock/" $CONFIG_PATH

sed -i "s/^#network_interface=/network_interface=/" $CONFIG_PATH
sed -i "s/^#media_dir=/media_dir=/" $CONFIG_PATH
sed -i "s/^#notify_interval=/notify_interval=/" $CONFIG_PATH
sed -i "s/^#friendly_name=/friendly_name=/" $CONFIG_PATH
sed -i "s/^#minissdpdsocket=/minissdpdsocket=/" $CONFIG_PATH

cat > $RUN_FILE << EOF
[Unit]
Description=MiniDLNA is a DLNA/UPnP-AV server software
After=syslog.target local-fs.target network.target

[Service]
User=nobody
Group=nobody
Type=forking
PIDFile=$RUN_DIR/minidlna.pid
ExecStart=/usr/local/sbin/minidlnad -f /etc/minidlna.conf -P /var/run/minidlna/minidlna.pid

[Install]
WantedBy=multi-user.target
EOF

echo "D $RUN_DIR 0755 nobody nobody -" > /etc/tmpfiles.d/minidlna.conf

rm -rf $DB_DIR
mkdir -p $DB_DIR
chown nobody:nobody $DB_DIR

chown root:root $RUN_FILE
chmod 644 $RUN_FILE

systemctl daemon-reload 
systemctl restart systemd-tmpfiles-setup.service
systemctl enable minidlna.service
systemctl restart minidlna.service

firewall-cmd --permanent --add-port=8200/tcp
firewall-cmd --permanent --add-port=1900/udp
firewall-cmd --reload

