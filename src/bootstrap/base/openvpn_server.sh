#/bin/bash

SERVER_NAME=localhost

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

CONFIG_PATH=$SERVER_PATH/server.conf

mkdir -p $SERVER_PATH/keys/
cp -a $KEYS_PATH/$SERVER_NAME.{crt,key} $KEYS_PATH/ca.crt $KEYS_PATH/dh*.pem $SERVER_PATH/keys/
cp -a /usr/share/doc/openvpn-*/sample/sample-config-files/roadwarrior-server.conf $CONFIG_PATH

sed -i 's/^ca\s.*/ca keys\/ca.crt/' $CONFIG_PATH
sed -i 's/^cert\s.*/cert keys\/localhost.crt/' $CONFIG_PATH
sed -i 's/^key\s.*/key keys\/localhost.key/' $CONFIG_PATH
sed -i 's/^dh\s.*/dh keys\/dh1024.pem/' $CONFIG_PATH
sed -i 's/^push "route 192.168.0.0/# push "route 192.168.0.0/' $CONFIG_PATH
sed -i 's/^push "dhcp-option/# push "dhcp-option/g' $CONFIG_PATH

echo "" >> $CONFIG_PATH
echo 'push "redirect-gateway def1"' >> $CONFIG_PATH
echo 'comp-lzo' >> $CONFIG_PATH
echo 'client-config-dir ccd'>> $CONFIG_PATH

mkdir $SERVER_PATH/ccd > /dev/null 2>&1

chmod 600 $SERVER_PATH/keys/*
chown root:root $SERVER_PATH/keys/*
restorecon -Rv $SERVER_PATH

ln -s /lib/systemd/system/openvpn\@.service /etc/systemd/system/multi-user.target.wants/openvpn\@server.service
systemctl -f enable openvpn@server.service
systemctl start openvpn@server.service

firewall-cmd --permanent --add-port=1194/udp

firewall-cmd --direct --passthrough ipv4 -A INPUT -i tun+ -j ACCEPT
firewall-cmd --direct --passthrough ipv4 -A FORWARD -i tun+ -j ACCEPT
firewall-cmd --direct --passthrough ipv4 -A FORWARD -i eth+ -o tun+ -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables-save

