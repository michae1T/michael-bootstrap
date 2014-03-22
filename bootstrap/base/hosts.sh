#!/bin/bash

if grep -q 'samantha' /etc/hosts ; then
  echo 'hosts already set'
else
  echo 'updating /etc/hosts...'

  cat >> /etc/hosts <<EOF

192.168.2.13    samantha
192.168.2.3     fermina
192.168.2.7     raspi
192.168.2.8     palomas-printer
192.168.2.1     palomas
192.168.2.42    palomas-ext

EOF

fi;

