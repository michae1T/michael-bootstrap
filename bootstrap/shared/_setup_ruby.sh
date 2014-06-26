#!/bin/bash

THIS_RUBY_PATCH_DIR=$RUBY_PATCH_DIR/ruby/$RUBY_VERSION

checkout_and_patch_repo "$RUBY_PROJECTS" "ruby" \
                        "https://github.com/ruby/ruby.git" \
                        "$RUBY_TAG" "$THIS_RUBY_PATCH_DIR"

checkout_and_patch_repo "$RUBY_PROJECTS" "rubygems" \
                        "https://github.com/rubygems/rubygems.git" \
                        "$GEM_TAG" ""

rm -rf $RUBY_INSTALL_DIR

cd $RUBY_PROJECTS/ruby
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
