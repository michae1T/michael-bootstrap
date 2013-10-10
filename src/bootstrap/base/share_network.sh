#!/bin/bash

LAN="eth0"
NET="wlan0"
LEASE_CONF="192.168.3.3,192.168.3.100,72h"
AMAZON_DNS="172.16.0.23"
ROUTER_IP="192.168.2.1"

yum -y install dnsmasq

echo "interface=$LAN" /etc/dnsmasq.conf
echo "dhcp-range=$LEASE_CONF" >> /etc/dnsmasq.conf

echo "nameserver $AMAZON_DNS" > /etc/resolv.conf
echo "nameserver $ROUTER_IP" >> /etc/resolv.conf

systemctl enable dnsmasq.service
systemctl restart dnsmasq.service

echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
sysctl -p

firewall-cmd --permanent --add-port=53/udp
firewall-cmd --permanent --add-port=67/udp

firewall-cmd --permanent --add-masquerade
firewall-cmd --direct --passthrough ipv4 -t nat -A POSTROUTING -j MASQUERADE

iptables-save


