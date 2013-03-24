#!/bin/bash

source `dirname $0`/../_environment.sh

INSTALL_DIR=/opt/ruby-1.8.7
RUBY=$INSTALL_DIR/bin/ruby
GEM=$INSTALL_DIR/bin/gem
RAKE=$INSTALL_DIR/bin/rake
GEMS_DIR=$INSTALL_DIR/lib/ruby/gems/1.8/gems

export PATH=$INSTALL_DIR/bin:$PATH

### required system gems ###

$GEM install bundler08 thin rdoc capistrano rspec \
                             net-ssh-gateway net-ssh net-sftp net-scp \
                             rails

$GEM install sinatra --version=1.2.6
$GEM install assette --version=0.1.7

$GEM install rake --version=0.8.7

### encyription stuff? ###

source $SHARED/_ruby_aes.sh

### libxml-ruby 1.1.3 needs to be patched for new versions of libxml2 ###

checkout_and_patch_repo "$RUBY_PROJECTS" "libxml-ruby" \
                        "https://github.com/xml4r/libxml-ruby.git" \
                        "REL_1_1_3" "$RUBY_PATCH_DIR/libxml-ruby"

cd $RUBY_PROJECTS/libxml-ruby
$RAKE gem
$GEM install admin/pkg/libxml-ruby-1.1.3.gem 

### install/patch passenger-nginx ###

$GEM install passenger --version 2.2.9 --no-ri --no-rdoc

BOOST_PATCH_DIR=$RUBY_PATCH_DIR/passenger/boost

if [ -d "$BOOST_PATCH_DIR" ] ; then
  cd $GEMS_DIR/passenger-2.2.9/ext
  cat $BOOST_PATCH_DIR/*.patch | patch -p0
fi;

mv /opt/nginx /opt/nginx.bak > /dev/null 2>&1
rm -rf /opt/nginx

$GEMS_DIR/passenger-2.2.9/bin/passenger-install-nginx-module --auto --auto-download --prefix=/opt/nginx --extra-configure-flags='--with-cc-opt=-Wno-error'

cd $START_DIR

