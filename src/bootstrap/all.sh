#!/bin/bash

shopt -s expand_aliases

ERROR_TERMS="fail|error|cannot|can't|invalid|skip|could\snot|couldn't|denied|not\sfound|errno"
ERROR_REGEX="(^|\s)($ERROR_TERMS)(([.]($|\s))|[^.]|($|\s))"

# these lines/warnings are expected during bootstrapping
EXCEPTIONS[0]="checking read count field in FILE structures... not found(OK if using GNU libc)"
EXCEPTIONS[1]="matching one couldn't be found."

alias FILTER_EXCEPTIONS="`for i in "${EXCEPTIONS[@]}"; do echo 'sed "/'$i'/ d " |'; done;`"
echo "starting bootstrap" | FILTER_EXCEPTIONS cat

function run_script {

  echo "running $1:$2 tasks..."

  $1/$2.sh 2>&1 |
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


cd `dirname $0`
mkdir -p log

#run_script test/all check_errors

run_script base yum
run_script base ruby_old
run_script gilt rails
