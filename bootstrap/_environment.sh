#!/bin/bash

START_DIR=`pwd`

cd `dirname $0`
OWNER_DIR=`pwd`
cd $OWNER_DIR/../..
REPO_DIR=`pwd`

cd $OWNER_DIR/../shared
SHARED=`pwd`

USER_HOME=`pwd | grep -o '\/home/[^\/]*'`
USER_STAT=`stat -c "%U:%G" $OWNER_DIR`
USER_OWNER=`stat -c "%U" $OWNER_DIR`

RUBY_PROJECTS=$USER_HOME/src/ruby
RUBY_PATCH_DIR=$REPO_DIR/ruby/patches

SCRIPTS_DIR=$REPO_DIR/scripts

SYS_SUDO_DIR=/opt/scripts/sys_sudo

unset -f git

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
  SCRIPT_PATH=`script_path $1`
  SOURCE_PATH=$SYS_SUDO_DIR/$1.sh

  if [ ! -e "$SOURCE_PATH" ] ; then echo "$SOURCE_PATH does not exist"; exit 1; fi;

  cat > $SCRIPT_PATH <<- EOF
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

script_path() {
  echo $USER_HOME/bin/set-$1
}

write_env_script() {
  SCRIPT_PATH=`script_path $1-env`
  BODY=`echo -e $2`
  SCPT=`echo -e $3 | sed 's/^/  /'`

  cat > $SCRIPT_PATH <<- EOF
#!/bin/bash

$BODY

if [ -z "\$NO_VERSION" ] ; then
$SCPT
fi;

if [ -z "\$NO_SHELL" ] ;
  then bash
fi;
EOF
  chown $USER_STAT $SCRIPT_PATH
  chmod +x $SCRIPT_PATH
}

yum_safe() {
  ORIG_DIR=`pwd`
  mkdir /tmp/yum-run > /dev/null 2>&1
  cd /tmp/yum-run
  yum $@
  cd $ORIG_DIR
}

error() {
  echo "error: $1"
  if [ -z "$2" ] ;
    then exit 1
    else exit $2
  fi;
}

require_root() {
  if [ `id -u` != "0" ] ;
    then error "root required!"
  fi;
}

path_regex() {
  echo "$@" | sed 's/\//\\\//g'
}

update_config() {
  PROP_NAME=$1
  VALUE=$2
  FILE_NAME=$3
  DIVIDER=$4

  if [ -z "$DIVIDER" ] ;
    then DIVIDER=" "
  fi;

  LINE_TO_INSERT="$PROP_NAME$DIVIDER$VALUE"
  LINE_TO_INSERT_R=`path_regex $LINE_TO_INSERT`

  PROP_INFO=`egrep -n "^(#[[:space:]]*)?$PROP_NAME$DIVIDER" $FILE_NAME`

  if [ -n "$PROP_INFO" ] ; then
    MATCHES=$(echo $PROP_INFO | sed -r "s/[0-9]+:/\\n/g" | wc --lines)
    if [[ "$MATCHES" != "2" ]] ; then
      error "multiple matches for $PROP_NAME in $FILE_NAME"
    fi;

    LINE_NUM=`echo $PROP_INFO | awk -F: '{ print $1 }'`
    LINE_TO_REPLACE=`echo $PROP_INFO | awk -F: '{ print $2 }'`
    
    if [[ "$LINE_TO_REPLACE" == "$LINE_TO_INSERT" ]] ; then
      echo "no need to update [$LINE_TO_REPLACE] at [$FILE_NAME:$LINE_NUM]"
    else
      sed -i "${LINE_NUM}s/.*/$LINE_TO_INSERT_R/" $FILE_NAME
      echo "updated [$LINE_TO_REPLACE] to [$LINE_TO_INSERT] at [$FILE_NAME:$LINE_NUM]"
    fi;
  else
    echo $LINE_TO_INSERT >> $FILE_NAME
    echo "added [$LINE_TO_INSERT] to [$FILE_NAME]"
  fi;

}

