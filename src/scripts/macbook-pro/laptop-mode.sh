#/bin/bash

if [ -z "$1" ] ;
  then echo "usuage: dock, free, or reset"
fi;

case "$1" in
  dock)
    rmmod b43
    rmmod tg3
    hciconfig hci0 down
    hciconfig hci1 up
    ;;
  free)
    modprobe b43
    rmmod tg3
    hciconfig hci0 down
    hciconfig hci1 down
    ;;
  reset)
    modprobe b43
    modprobe tg3
    hciconfig hci0 up
    hciconfig hci1 down
    ;;
  modes)
    echo dock free reset
    ;;
esac;

