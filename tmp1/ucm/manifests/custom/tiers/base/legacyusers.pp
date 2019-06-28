define ucm::custom::tiers::base::legacyusers (
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
  $svc_restart      = 'service centrifydc restart',

){

  User {
     ensure     => "$ensure",
     gid        => "$gid",
     home       => "$home",
     shell      => "$shell",
     groups     => "$groups",
     comment    => "$comment",
     forcelocal => $forcelocal,
     allowdupe  => $allowdupe,
     noop       => $readonly,
  }

  if $uid == 'null' {
    user {
      "$user":
        ensure => "$ensure",
     }
  }

  else {
    user {
      "$user":
        uid => $uid,
    }
  }

  if $ensure != 'absent' {
    exec {
      "${user}_homedir":
        path        => "$bin",
        command     => "mkdir -p $home ; chown $user.$gid $home",
        noop        => $readonly,
        refreshonly => true,
        subscribe   => User["$user"]
    }
    
    if $expires != true {
      exec {
        "${user}_password_expiry":
          path        => "$bin",
          command     => "chage -I -1 -m 0 -M -1 -E -1 ${user}",
          unless      => "chage -l $user | grep -i 'password expires' | grep never",
          noop        => $readonly,
          subscribe   => User["$user"]
      }
    }
  }
}

