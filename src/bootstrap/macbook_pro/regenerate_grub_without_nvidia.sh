#!/bin/bash

LINUX_GRUB_CONFIG=/etc/grub.d/10_linux
GRUB_IMPORT_CONFIG=/etc/default/grub

OUT_B='[[[outb 0x728 1]]][[[outb 0x710 2]]][[[outb 0x740 2]]][[[outb 0x750 0]]]'
OUT_B_CHECK='outb 0x728'

CUSTOM_PARAMS='pcie_aspm=force video=efifb i915.lvds_channel_mode=2 i915.modeset=1 radeon.modeset=0 i915.lvds_use_ssc=0 drm.debug=0x14 log_buf_len=16M'
CUSTOM_PARAMS_CHECK='radeon.modeset=0'

GRUB_IMPORT='GRUB_PRELOAD_MODULES="iorw"'
GRUB_IMPORT_CHECK=iorw

if [ -z "`ls /boot/efi/EFI/fedora/x86_64-efi 2>&1 | grep iorw`" ] ; then
  echo "updating boot modules"
  cp -R /usr/lib/grub/x86_64-efi /boot/efi/EFI/fedora/
else
  echo "skipping boot modules update"
fi;

if [ -z "`grep "$GRUB_IMPORT_CHECK" $GRUB_IMPORT_CONFIG`" ] ; then
  echo "updating imports"
  echo $GRUB_IMPORT >> $GRUB_IMPORT_CONFIG
else
  echo "skipping imports update"
fi;

if [ -z "`grep "$OUT_B_CHECK" $LINUX_GRUB_CONFIG`" ] ; then
  echo "updating outbs"
  sed -i "/gfxpayload/a$OUT_B" $LINUX_GRUB_CONFIG
  sed -i 's/\]\]\]/" | sed "s\/\^\/\$submenu_indentation\/"\n/g' $LINUX_GRUB_CONFIG 
  sed -i 's/\[\[\[/      echo "\t/g' $LINUX_GRUB_CONFIG
else 
  echo "skipping outb updates"
fi;

if [ -z "`grep "$CUSTOM_PARAMS_CHECK" $LINUX_GRUB_CONFIG`" ] ; then
  echo "updating kernel params"
  sed -i -e '/linuxefi/ s/${args}/${args} CUSTOM_PARAMS_HERE/' $LINUX_GRUB_CONFIG
  sed -i "s/CUSTOM_PARAMS_HERE/$CUSTOM_PARAMS/g" $LINUX_GRUB_CONFIG
else
  echo "skipping kernel param updates"
fi;

grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
echo "regenerated grub.cfg"
