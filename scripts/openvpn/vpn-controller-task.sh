#!/bin/bash

if [ -z "$TOGGLE_PATH" ] ; then
  echo "example: DNS_HOME= DNS_REMOTE= TOGGLE_PATH=/opt/vpn-toggler/tmp/toggle SERVICE_NAME=openvpn@michael.service ./vpn-controller.sh"
  exit 1
fi;

echo `date`
echo "service name: $SERVICE_NAME"
echo "toggle path: $TOGGLE_PATH"

if [ ! -e "/dev/net/tun" ] ; then
   mkdir /dev/net
   mknod /dev/net/tun c 10 200
fi;

if [[ `systemctl is-active $SERVICE_NAME 2>&1` == 'active' ]];
  then IS_ACTIVE=1; CUR_STATE=1;
  else CUR_STATE=0;
fi;

has_conn() {
  curl -s -v 10.8.0.1 2>&1 | grep '200 OK'
}

if [ -n "$IS_ACTIVE" ] ; then
  echo "vpn is up, checking if we need to restart..."
  if [ -z "`has_conn;has_conn;has_conn;has_conn`" ] ; then
    systemctl restart $SERVICE_NAME
    echo "...restarted"
  else 
    echo "...no restart"
  fi;
else 
  echo "vpn is not up..."
fi

# open vpn route to remote gw
IP=/usr/sbin/ip

REM_GW_IP=`/usr/sbin/route -n | grep ^52 | awk '{print $1}'`
if [ -n "$REM_GW_IP" ] ; then
  $IP route add table 11 to 52.3.89.213/32 via 10.8.0.5 dev tun0
  $IP rule add from 192.168.22.0/24 dev eth0 table 11 priority 11
else
  $IP route flush 11
  $IP route del table 11 to 52.3.89.213/32 via 10.8.0.5 dev tun0
  $IP rule del from 192.168.22.0/24 dev eth0 table 11 priority 11
fi;

RESOLV_FILE=/etc/resolv.conf
DNS_ACTIVE=`grep nameserver $RESOLV_FILE | awk '{ print $2 }'`

if [ -n "$IS_ACTIVE" ] ; then
  DNS_NEXT=$DNS_REMOTE
else
  DNS_NEXT=$DNS_HOME
fi;

if [ -n "$DNS_NEXT" ] ; then
  if [[ "$DNS_NEXT" != "$DNS_ACTIVE" ]] ; then
    echo "updating DNS from [$DNS_ACTIVE] to [$DNS_NEXT]"
    if [ -n "$DNS_ACTIVE" ] ; then
      sed -i "s/nameserver .*/nameserver $DNS_NEXT/" $RESOLV_FILE
    else
      echo "nameserver=$DNS_NEXT" >> $RESOLV_FILE
    fi;
  fi;
fi;

# if the toggle hasn't been set assume we want the vpn on
if [ ! -e "$TOGGLE_PATH" ] || [[ "`cat $TOGGLE_PATH`" == "on" ]];  
  then DESIRED_STATE=1 
  else DESIRED_STATE=0
fi;


if [[ "$CUR_STATE" != "$DESIRED_STATE" ]] ; then
  echo "toggle requested"
  if [ -z "$IS_ACTIVE" ] ; 
    then systemctl restart $SERVICE_NAME; echo "...vpn started";
    else systemctl stop $SERVICE_NAME; echo "...vpn stopped";
  fi
else
  echo "no toggle requested"
fi

echo =========
