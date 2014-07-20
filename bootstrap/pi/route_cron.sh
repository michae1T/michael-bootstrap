source `dirname $0`/../_environment.sh

config_sys_sudo $SCRIPTS_DIR/routevpn

echo "*/1 * * * * root  DNS_HOME=192.168.22.6 DNS_REMOTE=8.8.8.8 TOGGLE_PATH=/tmp/toggles/vpn-pi DEVICE=wlan0 VPN_GATEWAY_IP=192.168.22.7 REG_GATEWAY_IP=192.168.22.1 /opt/scripts/sys_sudo/vpn-route-controller-task.sh >> /var/log/vpn-route-controller-task.log" > /etc/cron.d/vpn-route-controller-task

systemctl enable crond.service
systemctl start crond.service

