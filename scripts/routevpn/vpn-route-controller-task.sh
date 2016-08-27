#!/bin/bash

if [ -z "$TOGGLE_PATH" ] ; then
  echo "example: DNS_HOME= DNS_REMOTE= TOGGLE_PATH=/opt/vpn-toggler/tmp/toggle DEVICE=wlan0 VPN_GATEWAY_IP= REG_GATEWAY_IP= ./vpn-controller.sh"
  exit 1
fi;

ROUTE=/usr/sbin/route

do-start() {
  $ROUTE del -net default dev $DEVICE
  sleep 5
  $ROUTE add -net default gw $VPN_GATEWAY_IP dev $DEVICE
}

do-stop() {
  $ROUTE del -net default dev $DEVICE
  sleep 5
  $ROUTE add -net default gw $REG_GATEWAY_IP dev $DEVICE
}

echo `date`
echo "toggle path: $TOGGLE_PATH"

if [ -n "`/usr/sbin/route -n | awk '{print $1,$2}' | grep '^0.0.0.0' | grep 192.168.22.7`" ] ;
  then IS_ACTIVE=1; CUR_STATE=1;
  else CUR_STATE=0;
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
    then do-start; echo "...vpn route started";
    else do-stop; echo "...vpn route stopped";
  fi
else
  echo "no toggle requested"
fi

echo =========

