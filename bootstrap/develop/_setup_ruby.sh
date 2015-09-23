#!/bin/bash

checkout_and_patch_repo "$RUBY_PROJECTS" "ruby" \
                        "https://github.com/ruby/ruby.git" \
                        "$RUBY_TAG"

checkout_and_patch_repo "$RUBY_PROJECTS" "rubygems" \
                        "https://github.com/rubygems/rubygems.git" \
                        "$GEM_TAG" ""

cd $RUBY_PROJECTS/ruby
RUBY_VERSION=`cat version.h | grep -e "RUBY_VERSION \"" | grep -o -P '\w+\.\w+\.\w+'`
RUBY_INSTALL_DIR=/opt/ruby-$RUBY_VERSION
rm -rf $RUBY_INSTALL_DIR

THIS_RUBY_PATCH_DIR=$RUBY_PATCH_DIR/ruby/$RUBY_VERSION
checkout_and_patch_repo "$RUBY_PROJECTS" "ruby" \
                        "https://github.com/ruby/ruby.git" \
                        "$RUBY_TAG" "$THIS_RUBY_PATCH_DIR"

autoconf && ./configure --prefix=$RUBY_INSTALL_DIR
make clean > /dev/null 2>&1
make && make install
chown -R $USER_STAT .

cd $RUBY_PROJECTS/rubygems
$RUBY_INSTALL_DIR/bin/ruby setup.rb

write_env_script "$ENV_NAME" \
  "export PATH=$RUBY_INSTALL_DIR/bin:\$PATH" \
  "ruby -v\necho 'rubygems' \`gem -v\`"

cd $START_DIR

