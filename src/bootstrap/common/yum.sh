#!/bin/bash

yum y update

yum -y groupinstall 'Development Tools'

yum install -y mongo* postgres* pgadmin* \
               java-1.* ant-* scala* maven* \
               puppet* rabbitmq* \
               perl-JSON perl-Module-Load \
               ImageMagick-perl \
               stunnel \
               tk* tcl* \               
               wget curl lynx \
               gdbm-devel openssl* \
               compat-libstd* compat-gcc* compat-readline* \
               libpng* gimp* \
               snakeyaml libyaml* perl-YAML* \
               patch readline* \
               zlib zlib-devel libffi-devel \
               bzip2 sqlite sqlite-devel \
               libxslt* libxml2* \
               avahi-tools cups*


yum install -y libreoffice* ktorrent kvirc


yum localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-stable.noarch.rpm

yum update

yum install -y gstreamer rhythmbox

yum install -y gstreamer-plugins-good gstreamer-plugins-bad gstreamer-plugins-ugly

yum install -y libdvdread libdvdnav lsdvd vlc*

yum install -y kaffeine xine xine-lib xine-lib-extras-freeworld unrar

rpm -ivh http://linuxdownload.adobe.com/adobe-release/adobe-release-i386-1.0-1.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
yum install flash-plugin

yum clean all



