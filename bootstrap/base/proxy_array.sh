#!/bin/bash

source `dirname $0`/../_environment.sh

if [ -n "BASE_PORT_IN" ] ;
  then BASE_PORT_IN=12344
fi;

if [ -n "BASE_PORT_OUT" ] ;
  then BASE_PORT_OUT=8122
fi;

yum_safe install polipo

systemctl disable polipo
systemctl stop polipo
rm -rf /usr/lib/systemd/system/polipo.service
systemctl daemon-reload

mkdir -p /etc/polipo/config.d

update_config 'CONFIG_DIR' '/etc/polipo/config.d' '/etc/sysconfig/polipo' '='

for i in 1 2 3 4 ; do

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

