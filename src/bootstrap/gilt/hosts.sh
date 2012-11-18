#!/bin/bash

if grep -q  'city.localhost' /etc/hosts ; then

echo "hosts already set"

else

echo "updating /etc/hosts..."

cat >> /etc/hosts <<EOF

127.0.0.1       man.localhost localhost admin.localhost giltgroupe.localhost city.localhost inv0 inv1 inv2 inv3 localhost.com

127.0.0.1       admin-city.localhost priceless.localhost wsj.localhost mc.localhost

74.119.74.13    gw1

EOF

fi;

