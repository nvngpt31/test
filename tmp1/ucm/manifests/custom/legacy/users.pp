define ucm::custom::legacy::users (
  $user             = $title, 
  $uid              = 'null',
  $gid              = 'users',
  $home             = "/home/${user}",
  $shell            = '/bin/bash',
  $comment          = "Puppet Managed System User",
  $ensure           = 'present',
  $bin              = '/usr/ucb:/usr/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin', 
  $expires          = true,
  $managehome       = 'false',
  $groups           = 'users',
  $forcelocal       = false,
  $allowdupe        = false,
  $ad_ignore        = 'false',
  $readonly         = 'true',
  $el               = "$::operatingsystemmajrelease",
  $onlyiftrue       = 'nullval',
  $onlyiffalse      = 'nullval',  
  $msg_onlyif       = "Skipping \"$title\".  Your \"onlyif\" param for user \"$title\" does not = either \"true\" or \"false\".",


){

  $ro = $::gro ? {
    'on'    => true,
    'off'   => false,
    default => $readonly
  }

  # set if either onlyiffalse or onlyiftrue is being called
  if    $onlyiftrue  != 'nullval' { $onlyifparams = 'enabled' }
  elsif $onlyiffalse != 'nullval' { $onlyifparams = 'enabled' }
  else { $onlyifparams = 'disbaled' }

  # set if either onlyif param value does not = true or false
  if $onlyifparams  == 'enabled' {
    if    $onlyiffalse == 'false' { $onlyifparamset = 'good' }
    elsif $onlyiftrue  == 'true'  { $onlyifparamset = 'good' }
    else { $onlyifparamset = 'bad' }
  }

  $svc_restart = $el ? {
    '7' => 'systemctl restart centrifydc',
    '6' => 'service centrifydc restart',
  }

  # --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

  if $user == 'nulluser' or $user == 'null' {}

  else {

    if $onlyifparams == 'enabled' {
      if $onlyifparamset != 'good' { notify { "msg_onlyifskip_${title}": message => "$msg_onlyif" }}
      else {  
        ucm::custom::tiers::base::legacyusers {
          "$user":
            uid         => $uid, 
            gid         => $gid,
            home        => $home,
            shell       => $shell,
            comment     => $comment,
            ensure      => $ensure,
            bin         => $bin,
            expires     => $expires,
            managehome  => $managehome,
            groups      => $groups,
            forcelocal  => $forcelocal,
            allowdupe   => $allowdupe,
            ad_ignore   => $ad_ignore,
            readonly    => $readonly,
            svc_restart => $svc_restart,
        } 
      }
    }

    else {
      ucm::custom::tiers::base::legacyusers {
        "$user":
          uid         => $uid,
          gid         => $gid,
          home        => $home,
          shell       => $shell,
          comment     => $comment,
          ensure      => $ensure,
          bin         => $bin,
          expires     => $expires,
          managehome  => $managehome,
          groups      => $groups,
          forcelocal  => $forcelocal,
          allowdupe   => $allowdupe,
          ad_ignore   => $ad_ignore,
          readonly    => $readonly,
          svc_restart => $svc_restart,
      }
    }
  }   
}


