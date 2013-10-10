#!/bin/bash


if [ -z "$TOGGLE_PATH" ] ; then
  echo "example: TOGGLE_PATH=/opt/vpn-toggler/tmp/toggle SERVICE_NAME=openvpn@michael.service ./vpn-controller.sh"
  exit 1
fi;

echo `date`
echo "service name: $SERVICE_NAME"
echo "toggle path: $TOGGLE_PATH"

if [[ `systemctl is-active $SERVICE_NAME` = 'active' ]];
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
