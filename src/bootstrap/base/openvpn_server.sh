#/bin/bash

SERVER_NAME=`hostname | cut -d. -f1a`

if [ -z "$KEYS_PATH" ] ;
  then KEYS_PATH=/root/easy-rsa/keys
fi;

if [ -z "$SERVER_PATH" ] ;
  then SERVER_PATH=/etc/openvpn
fi;

CONFIG_PATH=$SERVER_PATH/server.conf

yum install openvpn easy-rsa

cp -a $KEYS_PATH/$SERVER_NAME.{crt,key} $KEYS_PATH/ca.crt $KEYS_PATH/dh*.pem $SERVER_PATH/keys/
cp -a /usr/share/doc/openvpn-*/sample/sample-config-files/roadwarrior-server.conf $CONFIG_PATH

sed -i 's/^ca\s.*/ca keys\/ca.crt/' $CONFIG_PATH
sed -i 's/^cert\s.*/cert keys\/localhost.crt/' $CONFIG_PATH
sed -i 's/^key\s.*/key keys\/localhost.key/' $CONFIG_PATH
sed -i 's/^dh\s.*/dh keys\/dh1024.pem/' $CONFIG_PATH

restorecon -Rv $SERVER_PATH

ln -s /lib/systemd/system/openvpn\@.service /etc/systemd/system/multi-user.target.wants/openvpn\@server.service
systemctl -f enable openvpn@server.service
systemctl start openvpn@server.service

firewall-cmd --permanent --add-port=1194/udp

firewall-cmd --direct --passthrough ipv4 -A INPUT -i tun+ -j ACCEPT
firewall-cmd --direct --passthrough ipv4 -A FORWARD -i tun+ -j ACCEPT
firewall-cmd --direct --passthrough ipv4 -A FORWARD -i eth+ -o tun+ -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables-save
