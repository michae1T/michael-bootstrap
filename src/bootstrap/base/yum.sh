#!/bin/bash

yum -y update

yum -y groupinstall 'Development Tools'

yum -y install mongo* postgres* pgadmin* \
               java-1.7*openjdk* ant-* scala* maven* \
               ruby ruby-devel \
               puppet* rabbitmq* \
               perl-JSON perl-Module-Load \
               ImageMagick-perl \
               stunnel \
               tk* tcl* \
               wget curl lynx \
               ack pcre \
               gdbm-devel openssl* \
               openssh* \
               compat-libstd* compat-gcc* compat-readline* \
               libpng* gimp* \
               snakeyaml libyaml* perl-YAML* \
               patch readline* \
               zlib zlib-devel libffi-devel \
               bzip2 sqlite sqlite-devel \
               libxslt* libxml2* \
               avahi-tools cups*



yum -y install libreoffice-base libreoffice-calc libreoffice-core \
               libreoffice-impress libreoffice-kde libreoffice-math \
               libreoffice-writer* libreoffice-pres* libreoffice-open* \
               libreoffice-pdf* libreoffice-xslt* \
               libreoffice-langpack-en libreoffice-langpack-it \
               libreoffice-langpack-fr libreoffice-langpack-es \
               libreoffice-langpack-pt-BR libreoffice-langpack-uk \
               ktorrent kvirc

yum -y localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-stable.noarch.rpm

yum -y update

yum -y install gstreamer rhythmbox

yum -y install gstreamer-plugins-good gstreamer-plugins-bad gstreamer-plugins-ugly

yum -y install libdvdread libdvdnav lsdvd vlc*

yum -y install kaffeine xine xine-lib xine-lib-extras-freeworld unrar

rpm -ivh http://linuxdownload.adobe.com/adobe-release/adobe-release-i386-1.0-1.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
yum install flash-plugin

yum clean all



