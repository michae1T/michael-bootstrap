#!/bin/bash

if [ -z "$CLIENT_NAME" ] ; then
  echo "example: CLIENT_NAME= CLIENT_IPS= CLIENT_SUBNET= ./openvpn_server_add_client.sh"
  exit 1
fi;

if [ -z "$SERVER_PATH" ] ;
  then SERVER_PATH=/etc/openvpn
fi;

mkdir $SERVER_PATH/ccd  > /dev/null 2>&1

echo "iroute $CLIENT_IPS $CLIENT_SUBNET" > $SERVER_PATH/ccd/$CLIENT_NAME

