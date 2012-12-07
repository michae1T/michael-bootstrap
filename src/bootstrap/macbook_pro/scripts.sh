#!/bin/bash

source `dirname $0`/../_environment.sh

rm -rf /opt/scripts/sys_sudo
mkdir -p /opt/scripts/sys_sudo
cp $USER_HOME/src/scripts/macbook-pro/* /opt/scripts/sys_sudo
chown root:root /opt/scripts/sys_sudo/*

echo "#!/bin/bash" > bin/set-gfx-slow
echo "sudo /opt/scripts/sys_sudo/slow-gfx.sh" >> bin/set-gfx-slow
echo "" >> bin/set-gfx-slow
chmod +x bin/set-gfx-slow

echo "" >> /etc/sudoers
echo "ALL ALL=(ALL) NOPASSWD: /opt/scripts/sys_sudo/*.sh" >> /etc/sudoers
echo "" >> /etc/sudoers



