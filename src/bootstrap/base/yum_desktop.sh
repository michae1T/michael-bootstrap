#!/bin/bash

source `dirname $0`/../_environment.sh

yum_safe -y install firefox thunderbird \
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

yum_safe -y install gstreamer rhythmbox \
               gstreamer-plugins-good gstreamer-plugins-bad gstreamer-plugins-ugly \
               libdvdread libdvdnav lsdvd vlc* \
               kaffeine xine xine-lib xine-lib-extras-freeworld unrar ffmpeg

rpm -ivh 'http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm'
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
yum install flash-plugin

yum clean all

