#!/bin/bash

DEV0=/sys/class/drm/card0/device/power_profile
DEV1=/sys/class/drm/card1/device/power_profile

if [ -f "$DEV0" ] ;
  then echo low > $DEV0
fi;

if [ -f "$DEV1" ] ;
  then echo low > $DEV1
fi;

