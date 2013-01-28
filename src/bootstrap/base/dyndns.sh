#!/bin/bash

if [ -z "$DYNDNS_USERNAME" ] ; then echo "DYNDNS_USERNAME not set"; exit; fi;
if [ -z "$DYNDNS_PASSWORD" ] ; then  echo "DYNDNS_PASSWORD not set";  exit; fi;
if [ -z "$DYNDNS_DOMAIN" ] ; then echo "DYNDNS_DOMAIN not set"; exit; fi;

DYNCONFIG=/etc/ddclient.conf

echo "protocol=dyndns2" >> $DYNCONFIG
echo "use=web, web=checkip.dyndns.org/, web-skip='IP Address'" >> $DYNCONFIG
echo "server=members.dyndns.org" >> $DYNCONFIG
echo "login=$DYNDNS_USERNAME" >> $DYNCONFIG
echo "password=""$DYNDNS_PASSWORD" >> $DYNCONFIG
echo "$DYNDNS_DOMAIN.dyndns.org" >> $DYNCONFIG

systemctl enable ddclient.service
systemctl restart ddclient.service

