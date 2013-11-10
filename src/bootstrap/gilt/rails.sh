#!/bin/bash

source `dirname $0`/../_environment.sh

INSTALL_DIR=/opt/ruby-1.8.7
RUBY=$INSTALL_DIR/bin/ruby
GEM=$INSTALL_DIR/bin/gem
RAKE=$INSTALL_DIR/bin/rake
GEMS_DIR=$INSTALL_DIR/lib/ruby/gems/1.8/gems
GEM_OPTS='--no-ri --no-rdoc'

export PATH=$INSTALL_DIR/bin:$PATH

### required system gems ###

$GEM install rake --version=0.8.7 $GEM_OPTS

### encyription stuff? ###

source $SHARED/_ruby_aes.sh

### libxml-ruby 1.1.3 needs to be patched for new versions of libxml2 ###

checkout_and_patch_repo "$RUBY_PROJECTS" "libxml-ruby" \
                        "https://github.com/xml4r/libxml-ruby.git" \
                        "REL_1_1_3" "$RUBY_PATCH_DIR/libxml-ruby"

cd $RUBY_PROJECTS/libxml-ruby
$RAKE gem
$GEM install admin/pkg/libxml-ruby-1.1.3.gem $GEM_OPTS 


### extra stuff for capistrano deploys and general undocumented development :| ###

$GEM install bundler08 thin rdoc capistrano rspec \
                             net-ssh-gateway net-ssh net-sftp net-scp \
                             rails \
                             $GEM_OPTS


$GEM install sinatra --version=1.2.6 $GEM_OPTS
$GEM install assette --version=0.1.7 $GEM_OPTS


$GEM install rake $GEM_OPTS

cd $START_DIR

