#/bin/bash

if [ -z "$OPENVPN_USER$OPENVPN_SERVER" ] ;
  then echo "usage: SYSTEMCTL_PATH= SERVER_PATH= KEYS_PATH= OPENVPN_SERVER=localhost OPENVPN_USER=michael ./openvpn_client.sh"
  exit 1
fi;

if [ -z "$KEYS_PATH" ] ;
  then KEYS_PATH=/root/easy-rsa/keys
fi;

if [ -z "$SERVER_PATH" ] ;
  then SERVER_PATH=/etc/openvpn
fi;

if [ -z "$SYSTEMCTL_PATH" ] ; then
  SYSTEMCTL_PATH=/lib/systemd/system
else
  SKIP_START=1
fi;

CONFIG_PATH=$SERVER_PATH/$OPENVPN_USER.conf

yum install openvpn

mkdir -p $SERVER_PATH/keys

cp -af $KEYS_PATH/$OPENVPN_USER.key $KEYS_PATH/$OPENVPN_USER.crt $KEYS_PATH/ca.crt $SERVER_PATH/keys

cp -af /usr/share/doc/openvpn-*/sample/sample-config-files/client.conf $CONFIG_PATH

# disable optional options
sed -i 's/^;/\#/' $CONFIG_PATH

# set server path
sed -i "s/my-server-1/$OPENVPN_SERVER/" $CONFIG_PATH

# downgrade to nobody
sed -i 's/^\#user/user/' $CONFIG_PATH
sed -i 's/^\#group/group/' $CONFIG_PATH

# set keys
sed -i "s/^ca\s.*/ca keys\/ca.crt/" $CONFIG_PATH
sed -i "s/^cert\s.*/cert keys\/$OPENVPN_USER.crt/" $CONFIG_PATH
sed -i "s/^key\s.*/key keys\/$OPENVPN_USER.key/" $CONFIG_PATH

restorecon -Rv $CONFIG_PATH

ln $SYSTEMCTL_PATH/openvpn@.service $SYSTEMCTL_PATH/openvpn@$OPENVPN_USER.service

if [ -z "$SKIP_START" ] ; then
  systemctl enable openvpn@$OPENVPN_USER.service
  systemctl start openvpn@$OPENVPN_USER.service
  systemctl stop openvpn@$OPENVPN_USER.service
  systemctl disable openvpn@$OPENVPN_USER.service
fi;



