#!/bin/bash

ETH_IP=192.168.3.1

cat > /etc/sysconfig/network-scripts/ifcfg-eth0 <<EOF
TYPE=Ethernet
NAME=eth0
ONBOOT=yes
IPADDR0=$ETH_IP
PREFIX0=24
EOF

systemctl restart network.service

source ../base/share_network.sh

