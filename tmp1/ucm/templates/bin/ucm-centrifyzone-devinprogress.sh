#!/bin/bash

  while (( "$#" ))
  do case $1 in
       -z|--zone) shift && zone="$1" ;;
     esac
     shift
  done

  if [[ -z $zone ]]
  then echo "Please provide centrify zone name."
       exit 1
  fi 

  dir_var_cent="/var/centrifydc"
  mkdir /var/tmp/ucmcache

  if [[ -f ${dir_var_cent}/kset.zonename ]]
  then cp ${dir_var_cent}/kset.zonename 
