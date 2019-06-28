#!/bin/bash

  gitlab='http://gitlab.associatesys.local' maindir='/etc/puppetlabs/puppet' pdir='/etc/puppetlabs/code/environments/production'
  modpath="${pdir}/modules"                 hierapath="${pdir}/hieradata"    pmodgit="${gitlab}/tools/ucm.git"
  pmodlib="${gitlab}/tools/stdlib.git"      branch='development'             mod="${modpath}/ucm"
  lib="${modpath}/stdlib"                   class='ucm::halo'                logerr='/var/log/tda-puppet-error.log'
  pbin='/opt/puppetlabs/puppet/bin'         lbin='/usr/local/bin'            factsd='/etc/facter/facts.d'
  yamlcommon="${modpath}/ucm/files/halo/common.yaml"
  yamlbase="${modpath}/ucm/files/halo/base.yaml"
  yamlhiera="${modpath}/ucm/files/halo/hiera.yaml"

  # ------------------------------------------------------------------------------------------
  # SOFT LINK CREATION FOR PATH HELP
  for i in facter hiera mco puppet ; do ln -s ${pbin}/${i} ${lbin}/${i} >/dev/null 2>&1 ; done
  ln -s $modpath /root/modules >/dev/null 2>&1 ; ln -s $hierapath /root/hieradata >/dev/null 2>&1

  # ENSURE GIT IS INSTALLED
  yum install -y git >/dev/null 2>&1

  # ENSURE FIG PUPPET MODULE IS PRESENT (THE CODE)
  if [[ ! -d $mod ]] ; then git clone -b $branch $pmodgit $mod
    if [[ $? != '0' ]] ; then echo "...FAILED CLONING FIG MODULE ON `date`" >> $logerr ; exit 1 ; fi
  fi

  # ENSURE PUPPET STDLIB IS PRESENT (THE CODE)
  if [[ ! -d $lib ]] ; then git clone -b master $pmodlib $lib
    if [[ $? != '0' ]] ; then echo "...FAILED CLONING STDLIB MODULE ON `date`" >> $logerr ; exit 1 ; fi
  fi

  # ENSURE THE BASE SET OF DATA IS PRESENT (DEFAULT DATA FOR CONFIG TYPES)
  cp $yamlhiera ${maindir}/hiera.yaml ; cp $yamlbase ${hierapath}/base.yaml ; cp $yamlcommon ${hierapath}/common.yaml

  # ------------------------------------------------------------------------------------------
  # APPLY THE FIG CLASS, PARSES DATA FILES, ENFORCES CONFIG
  echo "" ; echo "" ; /usr/local/bin/puppet apply --detailed-exitcodes -t -e "include ucm::base"
  echo "" ; echo "" ; /usr/local/bin/puppet apply --detailed-exitcodes -t -e "include ${class}"
  if [[ $? = '0' || $? = '2' ]] ; then puppetexit=0 ; else puppetexit=1 ; fi

  if [[ $puppetexit = '0' ]] ; then exit 0 ; else exit 1 ; fi
