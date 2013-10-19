#!/bin/bash

source `dirname $0`/../_environment.sh

# so yum doesnt match files in the directory
mkdir /tmp/run-yum > /dev/null 2&>1
cd /tmp/run-yum

yum -y update

yum -y groupinstall 'Development Tools'

yum -y install git git-daemon \
               mongo* postgresql postgresql-server \
               java-1.7*openjdk* scala \
               maven maven-ant-plugin ant apache-ivy \
               ruby \
               puppet* rabbitmq* \
               perl-JSON perl-Module-Load \
               ImageMagick-perl ImageMagick-devel \
               stunnel \
               tk* tcl* \
               wget curl lynx telnet nc bind-utils \
               ack pcre \
               gdbm-devel openssl* \
               openssh* \
               compat-libstd* compat-gcc* compat-readline* \
               snakeyaml libyaml* perl-YAML* \
               patch readline* \
               zlib zlib-devel libffi-devel \
               bzip2 sqlite sqlite-devel \
               libxslt* libxml2 libxml2-devel \
               libpng-* libpng12 pangox-compat \
               fuse-encfs \
               tmux screen vim-enhanced \
               ddclient nodejs \
               cronie \
               openvpn* \
               nfs-utils \
               libusb-devel libusb-static systemd-devel libical-devel

yum clean all

if [ -n "$DESKTOP_BOOTSTRAP" ] ; then
  yum -y install firefox thunderbird \
               gitk pgadmin* \
               libreoffice-base libreoffice-calc libreoffice-core \
               libreoffice-impress libreoffice-kde libreoffice-math \
               libreoffice-writer* libreoffice-pres* libreoffice-open* \
               libreoffice-pdf* libreoffice-xslt* \
               libreoffice-langpack-en libreoffice-langpack-it \
               libreoffice-langpack-fr libreoffice-langpack-es \
               libreoffice-langpack-pt-BR libreoffice-langpack-uk \
               ktorrent kvirc \
               nautilus-extensions \
               digikam* kipi-plugins* \
               kde-l10n-British clearlooks-compact-gnome-theme \
               plasma-scriptengine-ruby korundum \
               powertop pidgin* banshee* \
               avahi-tools cups* \
               gimp* inkscape* \
               paprefs pavucontrol pavumeter \
               xbmc* \ 
               --exclude=gimp-help*

  yum -y localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-stable.noarch.rpm

  yum -y update

  yum -y install gstreamer rhythmbox \
                 gstreamer-plugins-good gstreamer-plugins-bad gstreamer-plugins-ugly \
                 libdvdread libdvdnav lsdvd vlc* \
                 kaffeine xine xine-lib xine-lib-extras-freeworld unrar ffmpeg

  rpm -ivh 'http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm'
  rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
  yum install flash-plugin

  yum clean all
fi;

cd $START_DIR

