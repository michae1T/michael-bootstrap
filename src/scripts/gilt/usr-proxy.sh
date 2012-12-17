#!/bin/bash

TO_PROXY_ORIG=$TO_PROXY

if [ `which $TO_PROXY` == "/usr/bin/$TO_PROXY" ] ; 
  then TO_PROXY=/usr/bin/$TO_PROXY.sys
fi;

if [ "$TO_PROXY" != "$TO_PROXY_ORIG" ] ; then 
  if [ ! -e "$TO_PROXY" ] ; 
    then echo "could not find $TO_PROXY"; exit 1;
  fi;
fi;

{
  $TO_PROXY "$@"
} < /dev/stdin


