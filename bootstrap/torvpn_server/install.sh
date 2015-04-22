#!/bin/bash

PORT=4194
TOR_IMAGE=michae1t/tor-gateway
VPN_IMAGE=michae1t/vpn-server

yum -y install docker
systemctl enable docker
systemctl start docker 

mkdir -p /opt && cd /opt && git clone https://github.com/jpetazzo/pipework.git
PIW=/opt/pipework/pipework

docker pull $TOR_IMAGE
docker pull $VPN_IMAGE

TOR_DPID=$(docker run -d --privileged --name=tor $TOR_IMAGE) 
VPN_DPID=$(docker run -d --privileged --name=vpn -p $PORT:1194 -v $KEYS_DIR:/etc/openvpn/keys $VPN_IMAGE)

$PIW br1 ${TOR_DPID:0:12} 192.168.66.1/24
$PIW br1 ${VPN_DPID:0:12} 192.168.66.2/24

firewall-cmd --permanent --add-port=$PORT/udp
firewall-cmd --reload


