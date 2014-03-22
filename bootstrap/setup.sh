#!/bin/bash

shopt -s expand_aliases

ERROR_TERMS="fail|error|cannot|can't|invalid|skip|could\snot|couldn't|denied|not\sfound|errno"
ERROR_REGEX="(^|\s)($ERROR_TERMS)(([.]($|\s))|[^.]|($|\s))"

# these lines/warnings are expected during bootstrapping
EXCEPTIONS[0]="checking read count field in FILE structures... not found(OK if using GNU libc)"
EXCEPTIONS[1]="matching one couldn't be found."

alias FILTER_EXCEPTIONS="`for i in "${EXCEPTIONS[@]}"; do echo 'sed "/'$i'/ d " |'; done;`"
echo "starting bootstrap" | FILTER_EXCEPTIONS cat

function run_checked {
  $1 2>&1 |
    tee log/$2.log |
    egrep -i "$ERROR_REGEX" |
    FILTER_EXCEPTIONS
    tee log/$2.error.log

  if [ ! -s log/$2.error.log ] ; then
    echo "done!"
  else
    echo "failed!"
    exit 1
  fi;
}

function run_script {
  echo "running $1:$2 tasks..."
  run_checked $1/$2.sh $2
}

if [ `id -u` != "0" ] ; 
  then echo "error: root required!"; exit 1;
fi;

cd `dirname $0`
mkdir -p log

TARGET=$1
if [ -z "$TARGET" ] ; then TARGET="help"; fi;
echo "running from target: $TARGET"

case "$TARGET" in
  test)
    run_script test/all check_errors
    ;;
  gilt)
    ;&
  yum)
    run_script base yum
    ;&
  user)
    run_script base user
    ;&
  services)
    run_script base services
    ;&
  postgres)
    run_script base postgres
    ;&
  java_stack_old)
    run_script base java_stack_old
    ;&
  ruby_old)
    run_script base ruby_old
    ;&
  hacks)
    run_script gilt hacks
    ;&
  hosts)
    run_script gilt hosts
    ;&
  rails)
    run_script gilt rails
    ;; 
  #) stop
  
  optional)
    ;&
  kernels)
    run_script base kernels
    ;&
  ruby_current)
    run_script base ruby_current
    ;;
  #) stop

  macbook_pro)
    ;&
  mac_scripts)
    run_script macbook_pro scripts
    ;;
  #) stop

  all)
   run_checked "./setup.sh gilt" gilt
   run_checked "./setup.sh macbook_pro" macbook_pro
   run_checked "./setup.sh optional" optional
   ;;
  #) stop
  --help)
    ;&
  help)
    echo ""
    echo "Usage: setup.sh [TARGET]"
    echo ""
    echo "Available Targets:"
    echo "  gilt - minimum gilt stack (old build tools, rails, nginx, etc.)"
    echo "  macbook_pro - post config for mbp... scripts /w sudo for hw control to /opt/script and ~/bin"
    echo "  optional - clones kernel repos to ~/src/kernel, installs base configs for them, builds newest ruby in /opt"
    echo "  all - everything"
    echo ""
    echo "Note: To recover from failure you can run from a specific sub target with setup.sh [SUB_TARGET]"
    echo ""
    ;;
  #) stop

  *)
    echo "error: unknown target!"
    ;;
esac

