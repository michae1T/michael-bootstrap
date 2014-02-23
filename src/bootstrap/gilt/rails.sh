#!/bin/bash

source `dirname $0`/../_environment.sh

INSTALL_DIR=/opt/ruby-1.8.7
RUBY=$INSTALL_DIR/bin/ruby
GEM=$INSTALL_DIR/bin/gem
RAKE=$INSTALL_DIR/bin/rake
GEMS_DIR=$INSTALL_DIR/lib/ruby/gems/1.8/gems
GEM_OPTS='--no-ri --no-rdoc'

export PATH=$INSTALL_DIR/bin:$PATH

### setup rake ###

# uninstall any newer versions of rake since they can interfere
yes y | $GEM uninstall rake --version '>0.8.7' 2> /dev/null || echo 'no other versions of rake found'

$GEM install rake --version=0.8.7 $GEM_OPTS

### ruby aes ###

wget http://aescrypt.sourceforge.net/aes-rb-0.1.0.tar.gz
tar -xvf aes-rb-0.1.0.tar.gz
cd aes-rb-0.1.0
/opt/ruby-1.8.7/bin/ruby extconf.rb && make && make install
cd .. && rm -rf aes-rb-0.1.0*

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
                             $GEM_OPTS


$GEM install sinatra --version=1.2.6 $GEM_OPTS
$GEM install assette --version=0.1.7 $GEM_OPTS
$GEM install rake $GEM_OPTS

write_env_script 'gilt' \
  "export PGUSER=web\nexport PGDATABASE=gilt_us_development\n\nexport PATH=/opt/apache-ant-1.8.2/bin:/opt/apache-maven-3.0.4/bin:\$PATH\nexport ANT_HOME=/opt/apache-ant-1.8.2\n\nexport PATH=~/src/gilt/bin:~/src/gilt/tools/bin:~/src/gilt/play-2.0:\$PATH\n\nNO_SHELL=1 source set-ruby-old-env\nNO_SHELL=1 source set-java-6-env\n" \
  "mvn -version | grep \"Apache Maven\"\nant -version\nsbt --version"

cd $START_DIR

