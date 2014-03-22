#/bin/bash

if [ -z "$1" ] ;
  then echo "usuage: dock, free, or reset"
fi;

case "$1" in
  dock)
#   rmmod b43 2> /dev/null
    rmmod wl 2> /dev/null
    rmmod tg3 2> /dev/null
    hciconfig hci0 down 2> /dev/null
    hciconfig hci1 up 2> /dev/null
    hcitool scanning  > /dev/null &
    ;;
  free)
#   modprobe b43 2> /dev/null
    modprobe wl 2> /dev/null
    rmmod tg3 2> /dev/null
    hciconfig hci0 down 2> /dev/null
    hciconfig hci1 down 2> /dev/null
    ;;
  reset)
#   modprobe b43 2> /dev/null
    modprobe wl 2> /dev/null
    modprobe tg3 2> /dev/null
    hciconfig hci0 up 2> /dev/null
    hciconfig hci1 down 2> /dev/null
    ;;
  modes)
    echo dock free reset
    ;;
esac;

