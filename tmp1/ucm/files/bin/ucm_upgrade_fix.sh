# Fix nonproduction servers ( ste ) for puppet upgrade isssues, change for other env's
# run from gw servers: e.g. ucm_upgrade_fix_ste.sh $ste_hostname

#ssh -q -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o ConnectTimeout=5 $1 "yum repolist"

 ###############
# fix1 - replace 10.175.130.151 with npectlvyumcl01.npeclientaux.local if found
################

out=`ssh -q -o UserKnownHostsFile=/dev/null -o "PasswordAuthentication=no" -o StrictHostKeyChecking=no -o ConnectTimeout=5 $1 "grep 10.175.130.151 /etc/yum.repos.d/*"`

if [ $? = 0 ] 
   then  
      echo "Replace for host: $1  $out to /npectlvyumcl01.npeclientaux.local " 
      ssh -q -o "PasswordAuthentication=no" -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o ConnectTimeout=5 $1 "sed -i s/10.175.130.151/npectlvyumcl01.npeclientaux.local/g /etc/yum.repos.d/*"
fi


#######################
#Fix2 - missing repository for salt dependent packages
#######################

out1=`ssh -q -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o ConnectTimeout=5 $1 "yum provides python-backports-ssl_match_hostname 2>&1"`

echo $out1 | grep "No Matches found"
if [ $? = 0 ] 
  then 
    echo "Deploying the rhel postpatch repo... on server: $1"
    out1=`ssh -q -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o ConnectTimeout=5 $1 "rpm -q --queryformat '%{VERSION}' redhat-release-server"`

    if [ $out1 = "6Server" ]
       then
        echo "Copy rhel6 repo...."
        scp -o "PasswordAuthentication=no" -o "StrictHostKeyChecking=no" -o "ConnectTimeout=10" -i /root/sudossh.privkey  rhel-postpatch.repo root@$1:/etc/yum.repos.d/
        ssh -q -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o ConnectTimeout=5 $1 "yum clean all"
    fi
fi

