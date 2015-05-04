#!/bin/bash

source `dirname $0`/../_environment.sh

[ -z "$AUTHORIZED_KEYS" ] && AUTHORIZED_KEYS=$USER_HOME/etc/private/contents/sshd/authorized_keys

if [ ! -f "$AUTHORIZED_KEYS" ] ;
  then error "\$AUTHORIZED_KEYS=$AUTHORIZED_KEYS not found"
fi

cp $AUTHORIZED_KEYS $USER_HOME/.ssh
chown $USER_STAT $USER_HOME/.ssh/authorized_keys
chmod 600 $USER_HOME/.ssh/authorized_keys

update_config "PasswordAuthentication" "no" /etc/ssh/sshd_config

systemctl enable sshd.service
systemctl restart sshd.service

