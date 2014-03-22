#!/bin/bash

FSTAB_FILE=/etc/fstab
MNT_PATH=/mnt
MNT_PATH_REGEX="\\/mnt"

if [ -z "$SHARE_NAME" ] ; then
  echo "example: IDENTIFIER='UUID=\"...\"' SHARE_NAME= FS_TYPE= OPTIONS=? ./fstab_add.sh"
  exit 1
fi;

if [ -z "$OPTIONS" ] ; 
  then OPTIONS='auto,exec,rw,noatime,nodiratime,nofail'
fi;

SHARE_DIR=$MNT_PATH/$SHARE_NAME
SHARE_DIR_REGEX="$MNT_PATH_REGEX\\/$SHARE_NAME"

echo "adding $SHARE_DIR..."

mkdir -p $SHARE_DIR
chown -R root:root $SHARE_DIR
chmod -R 777 $SHARE_DIR

if [ -n "`grep $SHARE_DIR $FSTAB_FILE`" ] ; then
  echo "deleting old entry"
  sed -i "/$SHARE_DIR_REGEX/d" $FSTAB_FILE
fi;
echo "$IDENTIFIER $SHARE_DIR              $FS_TYPE $OPTIONS 0 2" >> $FSTAB_FILE


