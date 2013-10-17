#!/bin/bash

if [ -z "$PPTPD_USERNAME" ] ; then echo "PPTPD_USERNAME not set"; exit; fi;
if [ -z "$PPTPD_PASSWORD" ] ; then  echo "PPTPD_PASSWORD not set";  exit; fi;

PASSWORD_FILE=/etc/ppp/chap-secrets

if [ -z "`grep $PPTPD_USERNAME $PASSWORD_FILE`" ] ; then
  echo "$PPTPD_USERNAME does not exist, adding..."
  echo "$PPTPD_USERNAME pptpd $PPTPD_PASSWORD *" >> $PASSWORD_FILE
else 
  echo "$PPTPD_USERNAME exists, updating..."
  sed -i "s/^$PPTPD_USERNAME pptpd .* \*/$PPTPD_USERNAME pptpd $PPTPD_PASSWORD \*/" $PASSWORD_FILE
fi;

#systemctl restart pptpd.service

