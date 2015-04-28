#!/bin/bash

source `dirname $0`/../_environment.sh

yum_safe install firefox thunderbird \
               xsel \
               gitk  \
               okular \
               libreoffice-base libreoffice-calc libreoffice-core \
               libreoffice-impress libreoffice-kde libreoffice-math \
               libreoffice-writer \
               libreoffice-opensymbol-fonts \
               libreoffice-pdfimport libreoffice-xsltfilter \
               libreoffice-langpack-en libreoffice-langpack-it \
               libreoffice-langpack-fr libreoffice-langpack-es \
               libreoffice-langpack-pt-BR libreoffice-langpack-uk \
               ktorrent kvirc \
               nautilus-extensions \
               digikam* kipi-plugins* \
               kde-l10n-British clearlooks-compact-gnome-theme \
               powertop pidgin* banshee* \
               avahi-tools cups* \
               gimp* inkscape* \
               paprefs pavucontrol pavumeter \
               --exclude=gimp-help*

yum_safe install --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-stable.noarch.rpm

yum_safe update

yum_safe install gstreamer rhythmbox \
               gstreamer-plugins-good gstreamer-plugins-bad gstreamer-plugins-ugly \
               gstreamer1-plugins-ugly gstreamer1-plugins-good \
               libdvdread libdvdnav lsdvd vlc* \
               kaffeine xine xine-lib xine-lib-extras-freeworld unrar ffmpeg

rpm -ivh 'http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm'
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
yum_safe install flash-plugin


