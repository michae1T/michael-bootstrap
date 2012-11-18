#!/bin/bash

source `dirname $0`/../_environment.sh

rm -rf /opt/scripts
mkdir -p /opt/scripts
cp $USER_HOME/src/scripts/macbook-pro/* /opt/scripts
chown root:root /opt/scripts/*

echo "" >> /etc/sudoers
echo "ALL ALL=(ALL) NOPASSWD: /opt/scripts/*.sh" >> /etc/sudoers
echo "" >> /etc/sudoers

echo "#!/bin/bash" > bin/set-gfx-slow
echo "sudo /opt/scripts/slow-gfx.sh" >> bin/set-gfx-slow
echo "" >> bin/set-gfx-slow
chmod +x bin/set-gfx-slow


