#/bin/bash`

source `dirname $0`/../_environment.sh

if [ -z "$OPENVPN_USER$OPENVPN_SERVER" ] ;
  then echo "example: DNS_HOME= DNS_REMOTE= SYSTEMCTL_PATH= KEYS_PATH= OPENVPN_SERVER=localhost OPENVPN_USER=michael ./openvpn_client.sh"
  exit 1
fi;

if [ -z "$KEYS_PATH" ] ;
  then KEYS_PATH=/root/easy-rsa/keys
fi;

if [ ! -e "$KEYS_PATH/ca.crt" ] ; then
  echo "error: $KEYS_PATH/ca.crt not found"
  exit 1
fi

if [ -z "$SERVER_PATH" ] ;
  then SERVER_PATH=/etc/openvpn
fi;

if [ -z "$SYSTEMCTL_PATH" ] ; then
  SYSTEMCTL_PATH=/lib/systemd/system
else
  SKIP_START=1
fi;

CONFIG_PATH=$SERVER_PATH/$OPENVPN_USER.conf

mkdir -p $SERVER_PATH/keys

cp -af $KEYS_PATH/$OPENVPN_USER.key $KEYS_PATH/$OPENVPN_USER.crt $KEYS_PATH/ca.crt $SERVER_PATH/keys

DOC_DIR=`cd /usr/share/doc/openvpn-* 2> /dev/null && pwd`
if [ -e "$DOC_DIR/sample/sample-config-files/client.conf" ] ; then
  SAMPLE_CONF=$DOC_DIR/sample/sample-config-files/client.conf
else
  SAMPLE_CONF=$DOC_DIR/sample-config-files/client.conf
fi;

cp -af $SAMPLE_CONF $CONFIG_PATH

# get rid of secondary server
sed -i 's/;remote.*//' $CONFIG_PATH

# disable optional options
sed -i 's/^;/\#/' $CONFIG_PATH

# set server path
update_config "remote" "$OPENVPN_SERVER" $CONFIG_PATH

# downgrade to nobody
update_config "user" "nobody" $CONFIG_PATH
update_config "group" "nobody" $CONFIG_PATH

# set keys
update_config "ca" 'keys\/ca.crt' $CONFIG_PATH
update_config "cert" `regex_path keys/$OPENVPN_USER.crt` $CONFIG_PATH
update_config "key" `regex_path keys/$OPENVPN_USER.key` $CONFIG_PATH

chmod 600 $SERVER_PATH/keys/*
chown root:root $SERVER_PATH/keys/*
restorecon -Rv $SERVER_PATH

SERVICE_NAME=openvpn@$OPENVPN_USER.service

ln $SYSTEMCTL_PATH/openvpn@.service $SYSTEMCTL_PATH/$SERVICE_NAME

if [ -z "$SKIP_START" ] ; then
  systemctl enable openvpn@$OPENVPN_USER.service
  systemctl start openvpn@$OPENVPN_USER.service
  systemctl stop openvpn@$OPENVPN_USER.service
  systemctl disable openvpn@$OPENVPN_USER.service
fi;

config_sys_sudo $USER_HOME/src/scripts/openvpn

echo "*/1 * * * * root  DNS_HOME=$DNS_HOME DNS_REMOTE=$DNS_REMOTE TOGGLE_PATH=/tmp/toggles/vpn-$OPENVPN_USER SERVICE_NAME=$SERVICE_NAME /opt/scripts/sys_sudo/vpn-controller-task.sh >> /var/log/vpn-controller-task.log" > /etc/cron.d/vpn-controller-task-$OPENVPN_USER

systemctl enable crond.service
systemctl start crond.service

