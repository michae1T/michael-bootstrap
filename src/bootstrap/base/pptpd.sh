#!/bin/bash

if [ -z "$PPTPD_USERNAME" ] ; then echo "PPTPD_USERNAME not set"; exit; fi;
if [ -z "$PPTPD_PASSWORD" ] ; then  echo "PPTPD_PASSWORD not set";  exit; fi;

echo "net.ipv4.ip_forward=1" > /etc/sysctl.d/pptpd.conf
sysctl -p

echo "localip 192.168.42.1" >> /etc/pptpd.conf
echo "remoteip 192.168.42.2-9" >> /etc/pptpd.conf
echo "" >> /etc/pptpd.conf

echo "ms-dns 172.16.0.23" >> /etc/ppp/options.pptpd

echo "$PPTPD_USERNAME pptpd $PPTPD_PASSWORD *" >> /etc/ppp/chap-secrets

systemctl enable pptpd.service
systemctl restart pptpd.service 

firewall-cmd --permanent --add-masquerade
firewall-cmd --permanent --add-port=1723/tcp

systemctl restart firewalld.service

