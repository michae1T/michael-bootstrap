#!/bin/bash


if [ -z "$TOGGLE_PATH" ] ; then
  echo "example: DNS_HOME= DNS_REMOTE= TOGGLE_PATH=/opt/vpn-toggler/tmp/toggle SERVICE_NAME=openvpn@michael.service ./vpn-controller.sh"
  exit 1
fi;

echo `date`
echo "service name: $SERVICE_NAME"
echo "toggle path: $TOGGLE_PATH"

if [[ `systemctl is-active $SERVICE_NAME 2>&1` == 'active' ]];
  then IS_ACTIVE=1
fi;

if [ -n "$IS_ACTIVE" ] ; then
  echo "vpn is up, checking if we need to restart..."
  if [ -z "`nc -w 500ms -i 500ms 10.8.0.1 22 2>&1 | grep SSH`" ] ; then
    systemctl restart $SERVICE_NAME
    echo "...restarted"
  else 
    echo "...no restart"
  fi;
else 
  echo "vpn is not up..."
fi
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

if [ -e $TOGGLE_PATH ] ; then
  echo "toggle requested"
  rm $TOGGLE_PATH
  if [ -z "$IS_ACTIVE" ] ; 
    then systemctl restart $SERVICE_NAME; echo "...vpn started";
    else systemctl stop $SERVICE_NAME; echo "...vpn stopped";
  fi
else
  echo "no toggle requested"
fi

echo =========
