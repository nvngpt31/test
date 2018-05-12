#!/bin/bash

  # CLASSES ARE RUN IN THE FOLLOWING ORDER
  #   - ucm::sme::main
  #   - ucm::tools
  #   - ucm::platforms
  #   - ucm::product

  fdir="/etc/facter/facts.d"
  product="`facter product`"
  line='# ============================================================================='
  banner='# UNITY CONFIGURATION MANAGEMENT'
  stamp="# STARTING: `date | tr '[:lower:]' '[:upper:]'`"
  clear 

  if [[ -z $product || $product = 'null' || $product = 'smeucmnull' ]] 
  then echo "" ; echo "# PRODUCT FACT NOT SET, PLEASE DO SO IN FOREMAN UI." ; echo "" ; exit 1
  fi 
  
  echo "" ; echo "$line" ; echo "# Q/A MESSAGE: UDPATING UCM CODE FOR TESTING" ; echo "$line" ; echo "" ; echo "" 
  puppet apply -t -e 'include ucm::sme::main'
  echo "" ; echo "" ; echo "$line" ; echo "$banner" ; echo "$stamp" ; echo "" ; echo ""

  # ===================================================================================
  ls -l ${fdir}/smeucmtool_* > /dev/null 2>&1
  if [[ $? = '0' ]] ; then
    for file in `cd $fdir && ls -1 smeucmtool_*` ; do
      tool="`echo $file | awk -F 'smeucmtool_' '{print $2}' | sed 's/.txt//g'`"
      echo "" ; echo "$line" ; echo "# CONFIGURING TOOL \"$tool\" " ; echo "" ; echo "" 
      echo "smeucmtool=${tool}" > ${fdir}/smeucmtool.txt

      if [[ `facter smeucmtool` = 'smeucmnull' ]] 
      then echo "# NO TOOL PROVIDED, SKIPPING"
      else puppet apply -e 'include ucm::tools'
      fi 
      echo ""
    done
  fi

  # ===================================================================================
  ls -l ${fdir}/ucmapp_* > /dev/null 2>&1
  if [[ $? = '0' ]] ; then
    for file in `cd $fdir && ls -1 ucmapp_*` ; do
      app="`echo $file | awk -F 'ucmapp_' '{print $2}' | awk -F '_ucmplatform' '{print $1}'`"
      platform="`echo $file | awk -F '_ucmplatform_' '{print $2}' | sed 's/.txt//g'`"
      echo "" ; echo "$line" ; echo "# CONFIGURING APP \"$app\" FOR PLATFORM \"$platform\" " ; echo "" ; echo "" 
      echo "smeucmapp=${app}" > ${fdir}/smeucmapp.txt
      echo "smeucmplatform=${platform}" > ${fdir}/smeucmplatform.txt

      if [[ `facter smeucmapp` = 'smeucmnull' ]] 
      then echo "# NO APP INSTANCES PROVIDED, SKIPPING"
      else puppet apply -e 'include ucm::platforms'
      fi 

      echo ""
    done
  fi

  # ===================================================================================
  echo "" ; echo "$line" ; echo "# CONFIGURING PRODUCT" ; echo "" ; echo "" 
  puppet apply -e 'include ucm::product'
  
  # ===================================================================================
  echo "smeucmapp=null" > ${fdir}/smeucmapp.txt
  echo "smeucmplatform=null" > ${fdir}/smeucmplatform.txt
  echo "smeucmtool=null" > ${fdir}/smeucmtool.txt
  rm -f ${fdir}/ucmapp_*

