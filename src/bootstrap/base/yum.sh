#!/bin/bash

yum -y update

yum -y groupinstall 'Development Tools'

yum -y install git gitk gitweb git-cvs git-daemon \
               mongo* postgres* pgadmin* \
               java-1.7*openjdk* scala* \
               maven maven-ant-plugin ant apache-ivy \
               ruby \
               puppet* rabbitmq* \
               perl-JSON perl-Module-Load \
               ImageMagick-perl ImageMagick-devel \
               stunnel \
               tk* tcl* \
               wget curl lynx \
               ack pcre \
               gdbm-devel openssl* \
               openssh* \
               compat-libstd* compat-gcc* compat-readline* \
               libpng-* \
               snakeyaml libyaml* perl-YAML* \
               patch readline* \
               zlib zlib-devel libffi-devel \
               bzip2 sqlite sqlite-devel \
               libxslt* libxml2 libxml2-devel \
               fuse-encfs \
               tmux screen vim-enhanced \
               ddclient \
               libusb-devel libusb-static systemd-devel libical-devel

yum clean all

if [ -n "$PPTPD_SERVER" ] ; then

  rpm -Uvh http://poptop.sourceforge.net/yum/stable/fc18/pptp-release-current.noarch.rpm 
  yum --enablerepo=poptop-stable install pptpd 

fi;

if [ -n "$DESKTOP_BOOTSTRAP" ] ; then
  yum -y install firefox thunderbird \
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
               gimp* \
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



