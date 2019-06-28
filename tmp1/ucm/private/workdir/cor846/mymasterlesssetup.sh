#!/bin/bash

  while (( "$#" ))
  do case $1 in
       -e|--environment) shift && env="$1"  ;;
     esac
     shift
  done

  if [[ -z $env ]]
  then echo "... please provide one of the following environment names with -e"
       echo ""
       ls -1 /etc/puppetlabs/code/environments
       echo ""
       exit 1
  fi

  cd /root
  if [[ ! -d /root/build ]]
  then mkdir -p build
       mv * build/
  fi

  if [[ ! -d /root/workdir ]]
  then mkdir -p /root/workdir
  else echo "...Already have a workdir, this setup already?"
#       exit 1
  fi

  cd /root
  sed -i '/^alias/d' /root/.bashrc
  yum install -y git ; echo ""
  git clone https://cor846@bitbucket.associatesys.local/scm/~cor846/temp.git ; echo "" ;
  mkdir -p /home/cor846/
  mkdir -p /home/cor846/repos

  if [[ ! -d /home/cor846/ ]]
  then echo "...no home dir?"
       exit 1
  fi

  cp -rp temp/conf/ssh/self/id_rsa* /home/cor846/.ssh ;
  chown -R cor846.users /home/cor846/ ;
  cp -rp temp/conf/ssh/deploy/id_rsa* /root/.ssh/ ;
  cd /root/workdir ;
  cp /tmp/unitycm-installer.tar.gz . ;
  tar -xzf unitycm-installer.tar.gz ;
  mv unitycm-installer/ucm/ . ;
  rm -rf rpms/ temp/ unitycm-installer* /tmp/unitycm-installer* ;
  cp -rp ucm/bin/global/* /usr/local/bin/ ;
  cp -rp ucm/files/misc/ngoms/workdir/* . ;
  chmod 0775 /usr/local/bin/* ;
  cp /root/workdir/dir_colors /root/.dir_colors ;
  cp /root/workdir/dir_colors /home/cor846/.dir_colors ;
  cd /home/cor846/repos
  git clone ssh://git@bitbucket.associatesys.local/sme/ucm.git
  git clone ssh://git@bitbucket.associatesys.local/sme/base.git

  cd /root
  ln -s /etc/puppetlabs/code/environments/
  ln -s /etc/puppetlabs/code/environments/${env}
  mkdir -p /etc/puppetlabs/code/hiera
  mkdir -p /etc/puppetlabs/code/hiera/${env}
  mkdir -p /etc/puppetlabs/code/hiera/${env}/hieradata
  ln -s /etc/puppetlabs/code/hiera/${env}/hieradata

  chown -R cor846.users /home/cor846
  setfact -f ucmos -v base
  cp /root/workdir/ucm/files/main/hiera/hiera.p5.dev.masterless.testing /etc/puppetlabs/puppet/hiera.yaml
  cp /root/workdir/ucm/files/main/common.yaml /root/hieradata/
  cp /root/workdir/ucm/files/main/base.yaml /root/hieradata/
  cd /root/hieradata
  ln -s /etc/puppetlabs/code/environments/${env}/modules/
  rm -rf /root/temp

  echo "... Testing hiera lookup of base data module's 'base::files:' "
  echo ""
  hiera base::files environment=production ucmos=base

