#!/bin/bash

EXPORTS_PATH=/etc/exports

if [ -z "$SHARE_NAME" ] ; then
  echo "example: SHARE_NAME= ./nfs_export.sh"
  exit 1
fi;

SHARE_DIR=/srv/$SHARE_NAME

echo "sharing $SHARE_DIR..."

mkdir -p $SHARE_DIR
chown -R root:root $SHARE_DIR
chmod -R 777 $SHARE_DIR

if [ -z "`grep $SHARE_DIR $EXPORTS_PATH`" ] ; then
  echo "$SHARE_DIR *(rw,no_subtree_check,sync,no_root_squash)" >> $EXPORTS_PATH
fi;

CONFIG_PATH=/etc/sysconfig/nfs
PORTMAP=111
SRV=2049
LOCKD=4045
STATD=1001
MOUNTD=4046

update_config "LOCKD_TCPPORT" $LOCKD $CONFIG_PATH "="
update_config "LOCKD_UDPPORT" $LOCKD $CONFIG_PATH "="
update_config "STATDARG" "'-p $STATD'" $CONFIG_PATH "="
update_config "STATD_PORT" $STATD $CONFIG_PATH "="
update_config "RPCMOUNTDOPTS" "'-p $MOUNTD'" $CONFIG_PATH "="
update_config "MOUNTD_PORT" $MOUNTD $CONFIG_PATH "="

restorecon -Rv $CONFIG_PATH

systemctl enable nfs-server.service
systemctl restart rpcbind.service
systemctl restart nfs-server.service
systemctl restart nfs-idmap.service
systemctl restart nfs-mountd.service
systemctl restart nfs-rquotad.service

/usr/sbin/exportfs -rav

firewall-cmd --permanent --add-port=$PORTMAP/tcp
firewall-cmd --permanent --add-port=$PORTMAP/udp
firewall-cmd --permanent --add-port=$SRV/tcp
firewall-cmd --permanent --add-port=$SRV/udp
firewall-cmd --permanent --add-port=$STATD/tcp
firewall-cmd --permanent --add-port=$STATD/udp
firewall-cmd --permanent --add-port=$LOCKD/tcp
firewall-cmd --permanent --add-port=$LOCKD/udp
firewall-cmd --permanent --add-port=$MOUNTD/tcp
firewall-cmd --permanent --add-port=$MOUNTD/udp
firewall-cmd --reload


