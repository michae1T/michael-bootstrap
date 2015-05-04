#!/bin/bash

rpm -Uvh http://poptop.sourceforge.net/yum/stable/fc18/pptp-release-current.noarch.rpm
yum --enablerepo=poptop-stable install pptpd

echo "net.ipv4.ip_forward=1" > /etc/sysctl.d/pptpd.conf
sysctl -p

echo "localip 192.168.42.1" >> /etc/pptpd.conf
echo "remoteip 192.168.42.3-100" >> /etc/pptpd.conf
echo "" >> /etc/pptpd.conf

echo "ms-dns 8.8.8.8" >> /etc/ppp/options.pptpd

systemctl enable pptpd.service
systemctl restart pptpd.service 

firewall-cmd --permanent --add-masquerade
firewall-cmd --permanent --add-port=1723/tcp
firewall-cmd --reload

