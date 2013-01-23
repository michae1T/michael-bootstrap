#!/bin/bash

source `dirname $0`/../_environment.sh

rm -rf /opt/scripts/sys_sudo
mkdir -p /opt/scripts/sys_sudo
cp $USER_HOME/src/scripts/macbook-pro/* /opt/scripts/sys_sudo
chown root:root /opt/scripts/sys_sudo/*

GFX_SCRIPT=$USER_HOME/bin/set-gfx-slow
echo "#!/bin/bash" > $GFX_SCRIPT
echo "sudo /opt/scripts/sys_sudo/slow-gfx.sh" >> $GFX_SCRIPT
echo "" >> $GFX_SCRIPT
chmod +x $GFX_SCRIPT

echo "" >> /etc/sudoers
echo "ALL ALL=(ALL) NOPASSWD: /opt/scripts/sys_sudo/*.sh" >> /etc/sudoers
echo "" >> /etc/sudoers



