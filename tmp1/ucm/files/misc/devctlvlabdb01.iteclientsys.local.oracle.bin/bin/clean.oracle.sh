#!/bin/bash

  files='
  /app/grid/home/.profile
  /app/oracle/home/.profile
  /etc/modprobe.d/bonding.conf
  /etc/udev/rules.d/90-oracle.rules
  /etc/sudoers.d/oracle_sudo
  /app/grid/product/12.1.0.2/inventory/response/grid_install.rsp
  /app/grid/home/.ssh/authorized_keys
  /app/grid/home/.ssh/id_rsa
  /app/grid/home/.ssh/id_rsa.pub
  /app/grid/product/12.1.0.2/network/admin/listener.ora
  /app/oracle/home/.ssh/authorized_keys
  /app/oracle/home/.ssh/id_rsa
  /app/oracle/home/.ssh/id_rsa.pub
  /usr/local/bin/oracle-standalone-setup-2018
  /opatch_upgrade_6880880_opatch_upgrade_asm_12.1.0.1.8.ksh
  /opatch_upgrade_6880880_opatch_upgrade_db_12.1.0.1.8.ksh'

  fs='
  /orabin
  /app/oracle
  /app/agent
  /app/grid'

  lv='
  agent_lv  
  grid_lv   
  oracle_lv'

  pv='
  /dev/sdb1 
  /dev/sdc1 
  /dev/sdd1'

  disks='
  /dev/sdb 
  /dev/sdc 
  /dev/sdd'

  # ----------------------------------------------------------------------------
  cp /etc/fstab.clean /etc/fstab
  rm -f /etc/facter/facts.d/mountpoint_initially_configured.txt
  rm -f /usr/local/bin/primitive_mount
  rm -rf /etc/ora*

  for i in $fs ; do 
    umount $i >/dev/null 2>&1
  done 

  for i in $files
  do rm -f $i >/dev/null 2>&1
  done 

  rm -rf /app/* >/dev/null 2>&1

  for i in $lv ; do 
    lvremove --force /dev/appvg/${i} >/dev/null 2>&1
  done 

  vgremove appvg >/dev/null 2>&1 
 
  for i in $pv ; do 
    pvremove --force ${i} >/dev/null 2>&1
  done 

  for i in $disks ; do 
    echo -e "o\nd\nw" | fdisk $i >/dev/null 2>&1
    dd if=/dev/zero of=${i} bs=1k count=1 >/dev/null 2>&1
    for i in sdb sdc sdd sde sdf ; do dd if=/dev/zero of=/dev/${i} bs=1048576 count=50 ; done
  done 

  sed -i '/^zgrid/d ; /^zoracle/d' /etc/centrifydc/user.ignore >/dev/null 2>&1
  userdel zoracle   >/dev/null 2>&1
  userdel zgrid     >/dev/null 2>&1
  groupdel oper     >/dev/null 2>&1
  groupdel asmadmin >/dev/null 2>&1
  groupdel asmdba   >/dev/null 2>&1

  service centrifydc restart >/dev/null 2>&1
  udevadm control --reload-rules && udevadm trigger

  echo ""
  echo ""
  cat /etc/fstab
  echo ""
  echo ""
  echo "... GOING DOWN FOR REBOOT IN"
  for i in 6 5 4 3 2 1 
  do echo "... $i" ; sleep 1
  done 
  init 6




