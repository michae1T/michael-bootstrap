#!/bin/bash

echo 'net.ipv4.ip_forward=1' > /etc/sysctl.d/sharenet.conf
echo 'net.ipv6.conf.all.forwarding=1' >> /etc/sysctl.d/sharenet.conf
sysctl -p

firewall-cmd --permanent --add-port=53/udp
firewall-cmd --permanent --add-port=67/udp
firewall-cmd --permanent --add-masquerade
firewall-cmd --reload

firewall-cmd --direct --passthrough ipv4 -t nat -A POSTROUTING -j MASQUERADE
firewall-cmd --direct --passthrough ipv6 -t nat -A POSTROUTING -j MASQUERADE

iptables-save


