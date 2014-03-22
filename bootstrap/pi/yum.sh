#/bin/bash

VER=$(rpm -E %fedora)
yum install http://ccrma.stanford.edu/planetccrma/mirror/pidora/linux/planetccrma/$VER/armv6hl/planetccrma-repo-1.1-3.fc${VER}.ccrma.noarch.rpm
