#!/bin/bash

source `dirname $0`/../_environment.sh

if [ -z "$SERVER_CONFIG_SOURCE_DIR" ] ; then
  POSSIBLE_SOURCE=$DEFAULT_CONFIG_DIR/dnsmasq
  if [ -e "$POSSIBLE_SOURCE" ] ; then
    SERVER_CONFIG_SOURCE_DIR=$POSSIBLE_SOURCE
  fi;
  POSSIBLE_SOURCE=$REPO_DIR/config/dnsmasq
  if [ -e "$POSSIBLE_SOURCE" ] ; then
    SERVER_CONFIG_SOURCE_DIR=$POSSIBLE_SOURCE
  fi;
fi;

if [ -z "$SERVER_CONFIG_NAME" ] ; then
  example "SERVER_CONFIG_NAME=home SERVER_CONFIG_SOURCE_DIR=~/src/michael-configs/dnsmasq ./dnsmasq.sh"
fi;

yum install dnsmasq

cp $SERVER_CONFIG_SOURCE_DIR/dnsmasq.conf /etc/ --backup --suffix=.bak
rm -rf /etc/dnsmasq.d.bak
mv -Tf /etc/dnsmasq.d /etc/dnsmasq.d.bak
mkdir -p /etc/dnsmasq.d

add_all_to_hosts $SERVER_CONFIG_SOURCE_DIR/hosts

POSSIBLE_CONFIG_OVERRIDES=$SERVER_CONFIG_SOURCE_DIR/dnsmasq.d/$SERVER_CONFIG_NAME.conf
if [ -e "$POSSIBLE_CONFIG_OVERRIDES" ] ; then
    cp $POSSIBLE_CONFIG_OVERRIDES /etc/dnsmasq.d/
  else
    echo "warning: could not find $POSSIBLE_CONFIG_OVERRIDES"
fi;



systemctl enable dnsmasq.service
systemctl restart dnsmasq.service
