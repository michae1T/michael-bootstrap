#!/bin/bash

source `dirname $0`/../_environment.sh

RUBY_INSTALL_DIR=/opt/jruby
RUBY_TAG=1.7.6
RUBY_VERSION=1.7.6
ZIP_NAME=jruby-dist-1.7.6-bin.zip
OUT_NAME=jruby-1.7.6
INSTALL_PATH=/opt/jruby-$RUBY_VERSION

MVN=mvn
THIS_RUBY_PATCH_DIR=$RUBY_PATCH_DIR/ruby/$RUBY_VERSION

checkout_and_patch_repo "$RUBY_PROJECTS" "jruby" \
                        "https://github.com/jruby/jruby.git" \
                        "$RUBY_TAG" "$THIS_RUBY_PATCH_DIR"

rm -rf $INSTALL_PATH
cd $RUBY_PROJECTS/jruby

$MVN clean && $MVN && $MVN -Pdist \
    && unzip maven/jruby-dist/target/$ZIP_NAME \
    && mv $OUT_NAME $INSTALL_PATH

rm $INSTALL_PATH/bin/*.bat $INSTALL_PATH/bin/*.exe $INSTALL_PATH/bin/*.dll
ln -s $INSTALL_PATH/bin/jruby $INSTALL_PATH/bin/ruby

chown -R $USER_STAT .

write_env_script 'jruby' \
  "export PATH=$INSTALL_PATH/bin:\$PATH" \
  "ruby -v"

