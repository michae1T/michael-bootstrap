#!/bin/bash

source `dirname $0`/../_environment.sh

yum_safe install firefox thunderbird \
               ntfs-3g ntfsprogs \
               xsel \
               okular \
               libreoffice-calc libreoffice-core \
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
               powertop \
               avahi-tools cups* \
               gimp* inkscape* \
               paprefs pavucontrol pavumeter \
               bluez-* fuse-encfs \
               hdparm \
               -x gimp-help*

yum_safe remove amarok calligra*

yum_safe install http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-24.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-24.noarch.rpm

yum_safe install gstreamer rhythmbox \
               gstreamer-plugins-good gstreamer-plugins-bad gstreamer-plugins-ugly \
               gstreamer1-plugins-ugly gstreamer1-plugins-good \
               libdvdread libdvdnav lsdvd vlc* \
               kaffeine xine xine-lib xine-lib-extras-freeworld unrar ffmpeg

# dnf install 'http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm'
# yum_safe install flash-plugin


