#!/bin/bash

START_DIR=`pwd`

cd `dirname $0`
OWNER_DIR=`pwd`

cd $OWNER_DIR/../shared
SHARED=`pwd`

cd $OWNER_DIR/../../..
USER_HOME=`pwd`
USER_STAT=`stat -c "%U:%G" $OWNER_DIR`
USER_OWNER=`stat -c "%U" $OWNER_DIR`

RUBY_PROJECTS=$USER_HOME/src/ruby
RUBY_PATCH_DIR=$RUBY_PROJECTS/patches

SYS_SUDO_DIR=/opt/scripts/sys_sudo

cd $START_DIR

checkout_and_patch_repo() {
  SRC_DIR=$1
  PROJECT_NAME=$2
  GIT_REPO=$3
  TAG=$4
  PATCH_DIR=$5

  mkdir -p $SRC_DIR

  PROJECT_DIR=$SRC_DIR/$PROJECT_NAME

  if [ -d "$PROJECT_DIR" ] ;
    then cd $PROJECT_DIR && git add . && git reset --hard && git fetch
    else cd $SRC_DIR && git clone $GIT_REPO
  fi;
  cd $PROJECT_DIR && git checkout $TAG

  if [ -n "$PATCH_DIR" ] && [ -d "$PATCH_DIR" ] ; then
    cd $PROJECT_DIR
    echo "patching from: $PATCH_DIR"
    cat $PATCH_DIR/* | patch -p1
  fi;

  chown -R $USER_STAT $PROJECT_DIR

}

checkout_repo() {
  checkout_and_patch_repo "$1" "$2" "$3" "$4" ""
}

make_sys_sudo_redirect() {
  SCRIPT_PATH=$USER_HOME/bin/set-$1
  SOURCE_PATH=$SYS_SUDO_DIR/$1.sh

  if [ ! -e "$SOURCE_PATH" ] ; then echo "$SOURCE_PATH does not exist"; exit 1; fi;

cat > $SCRIPT_PATH <<EOF
#!/bin/bash
sudo /opt/scripts/sys_sudo/$1.sh

EOF

  chmod +x $SCRIPT_PATH
  chown $USER_STAT $SCRIPT_PATH
}

config_sys_sudo() {
  mkdir -p $SYS_SUDO_DIR
  cp -f $1/*.sh $SYS_SUDO_DIR

  chown root:root $SYS_SUDO_DIR
  chown root:root $SYS_SUDO_DIR/*
  chmod 755 $SYS_SUDO_DIR
  chmod 755 $SYS_SUDO_DIR/*.sh
  if [ -z "`grep sys_sudo /etc/sudoers`" ] ; then
    echo "" >> /etc/sudoers
    echo "ALL ALL=(ALL) NOPASSWD: $SYS_SUDO_DIR/*.sh" >> /etc/sudoers
    echo "" >> /etc/sudoers
  fi;
}

