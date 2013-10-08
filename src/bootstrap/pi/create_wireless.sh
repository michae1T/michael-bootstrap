if [ -z "$W_NAME" ] ; 
  then echo example: W_INSTALL_PATH=. W_SECURITY=wpa W_DEFAULT=1 W_NAME=heyhey W_PASSWORD=you ./create-wireless.sh
fi;

if [ -z "$W_INSTALL_PATH" ] ; 
  then W_INSTALL_PATH=/etc/sysconfig/network-scripts
fi;

if [[ "$W_SECURITY" = "wpa" ]] ;  then
  SEC="KEY_MGMT=WPA-PSK"
  PASS="WPA_PSK='$W_PASSWORD'"
else
  SEC="SECURITYMODE=open\nDEFAULTKEY=1"
  PASS="KEY_PASSPHRASE1=$W_PASSWORD"
fi;

if [ -n "$W_DEFAULT" ] ; then
  DEF="DEFROUTE=yes\nONBOOT=no"
fi;

cat > $W_INSTALL_PATH/ifcfg-$W_NAME <<EOF
ESSID="$W_NAME"
NAME=$W_NAME
MODE=Managed
TYPE=Wireless
BOOTPROTO=dhcp
IPV4_FAILURE_FATAL=yes
IPV6INIT=no
PEERDNS=yes
PEERROUTES=yes
`echo -e $SEC`
`echo -e $DEF`
EOF

echo $PASS > $W_INSTALL_PATH/keys-$W_NAME
