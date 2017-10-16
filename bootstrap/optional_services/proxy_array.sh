#!/bin/bash

# loadbalancer (haproxy) -> http proxies (polipo) -> socks tunnels (ssh)
# user sets up array of dynamic socks tunnels, this provides infrastructure to feed
# off them in a consistent manner
#
# map:
# num - conn - socks - polipo - haprxy group - notes
# 1   - gw1  - x     - x      -              - build only
# 2   - gw1  - x     - x      -   x
# 3   - gw1  - x     - x      -   x
# 4   - gw2  - x     - x      -   x
# 5   - gw2  - x     - x      -   x
# 6   - gw2  - x     - x      -              - docker & other
#
# defaults: 
#
# dynamic socks tunnels  - 12345-12340
# polipo http proxies    - 8123-8128
# haproxy balanced proxy - 8120
#

source `dirname $0`/../_environment.sh

if [ -z "$BASE_PORT_IN" ] ;
  then BASE_PORT_IN=12344
fi;

if [ -z "$BASE_PORT_OUT" ] ;
  then BASE_PORT_OUT=8122
fi;

if [ -z "$HAPROXY_CONFIG" ];
  then HAPROXY_CONFIG=/etc/haproxy/haproxy.cfg
fi;

yum_safe install polipo || echo warning: polipo not found in yum repos
yum_safe install haproxy

mkdir -p /etc/polipo/config.d

update_config 'CONFIG_DIR' '/etc/polipo/config.d' '/etc/sysconfig/polipo' '='

for i in 1 2 3 4 5 6 ; do

  systemctl stop polipo${i}.service

  IN_PORT=$(($BASE_PORT_IN + $i))
  OUT_PORT=$(($BASE_PORT_OUT + $i))

  cat > /etc/polipo/config.d/config${i}.config <<-EOF
daemonise = true
pidFile = /var/run/polipo/polipo${i}.pid
logFile = /var/log/polipo/polipo${i}.log
proxyAddress = "::0"
allowedPorts = 1-65535
tunnelAllowedPorts = 1-65535
allowedClients = "127.0.0.1"
socksParentProxy = "localhost:$IN_PORT"
socksProxyType = socks5
proxyPort = $OUT_PORT
EOF

CONFIG_FILE=config${i}.config

  cat > /usr/lib/systemd/system/polipo${i}.service <<-EOF
[Unit]
Description=A caching web proxy
Documentation=man:polipo(1) http://localhost:$OUT_PORT/

[Service]
Type=forking
User=polipo
Group=polipo
EnvironmentFile=/etc/sysconfig/polipo
ExecStart=/usr/bin/polipo -c \${CONFIG_DIR}/$CONFIG_FILE
ExecReload=/usr/bin/kill -USR1 \$MAINPID

[Install]
WantedBy=multi-user.target
EOF

  semanage port -a -t http_cache_port_t -p tcp $OUT_PORT
  semanage port -a -t http_cache_port_t -p tcp $IN_PORT
  systemctl daemon-reload
  systemctl enable polipo${i}.service
  systemctl start polipo${i}.service

done;

# set up load balancer

semanage port -a -t http_cache_port_t -p tcp 8120
setsebool -P httpd_can_network_relay 1


cat > $HAPROXY_CONFIG <<-EOF
global
    log         127.0.0.1 local2
    chroot      /var/lib/haproxy
    pidfile     /var/run/haproxy.pid
    maxconn     8000
    user        haproxy
    group       haproxy
    daemon
    stats socket /var/lib/haproxy/stats
defaults
    mode                    tcp
    log                     global
    option                  httplog
    option                  dontlognull
    option http-server-close
    option forwardfor       except 127.0.0.0/8
    option                  redispatch
    retries                 3
    timeout http-request    10s
    timeout queue           1m
    timeout connect         10s
    timeout client          1m
    timeout server          1m
    timeout http-keep-alive 10s
    timeout check           10s
    maxconn                 8000
frontend  main
    bind                    *:8120
    default_backend         app
backend app
    mode tcp
    balance leastconn
EOF

for i in 1 2 3 4 ; do
  OUT_PORT=$(($BASE_PORT_OUT + $i + 1))
  echo "    server  app$i 127.0.0.1:$OUT_PORT check" >>  $HAPROXY_CONFIG
done;

systemctl enable haproxy.service
systemctl restart haproxy.service

