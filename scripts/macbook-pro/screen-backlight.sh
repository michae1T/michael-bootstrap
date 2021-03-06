#!/bin/bash                                                                                            

# Anthony Fejes (apfejes@gmail.com)
# Template taken from post by Fran Diéguez at
# http://www.mabishu.com/blog/2010/06/24/macbook-pro-keyboard-backlight-keys-on-ubuntu-gnulinux/
#
# This program just modifies the value of video brightness for Apple Laptops
# You must run it as root user or via sudo.
# As a shortcut you could allow to admin users to run via sudo without password
# prompt. To do this you must add sudoers file the next contents:
#
#   ALL = NOPASSWD: /usr/sbin/mbp_backlight

# After this you can use this script as follows:
#
#     Increase backlight keyboard:
#           $ sudo mbp_backlight up
#     Decrease backlight keyboard:
#           $ sudo mbp_backlight down
#

echo 'hi'

BACKLIGHT=$(cat /sys/class/backlight/gmux_backlight/brightness)
MAX=$(cat /sys/class/backlight/gmux_backlight/max_brightness)
MIN=4
INCREMENT=1000

if [ $UID -ne 0 ]; then
    echo "Please run this program as superuser"
    exit 1
fi

case $1 in

    up)
        TOTAL=`expr $BACKLIGHT + $INCREMENT`
        if [ $BACKLIGHT -eq $MAX ]; then
                exit 1
        fi
        if [ $TOTAL -gt $MAX ]; then
            let TOTAL=MAX
        fi
        echo $TOTAL > /sys/class/backlight/gmux_backlight/brightness
        ;;
    down)
        TOTAL=`expr $BACKLIGHT - $INCREMENT`
        if [ $BACKLIGHT -eq $MIN ]; then
                exit 1
        fi
        if [ $TOTAL -lt $MIN ]; then
            let TOTAL=MIN
        fi
        echo $TOTAL > /sys/class/backlight/gmux_backlight/brightness
        ;;
    *)
        echo "Use: screen-backlight up|down"
        ;;
esac
 
