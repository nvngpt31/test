define ucm::custom::tiers::product::users (
  $user       = $title,
  $uid        = 'null',
  $gid        = 'users',
  $home       = "/home/${user}",
  $shell      = '/bin/bash',
  $comment    = "Puppet Managed System User",
  $ensure     = 'present',
  $bin        = lookup('execpath'),
  $expires    = true,
  $cronaccess = false,
  $adignore   = false,
  $readonly   = true,

){

  if $uid != 'null' {
    user {
      "$user":
        ensure  => "$ensure",
        uid     => "$uid",
        gid     => "$gid",
        home    => "$home",
        shell   => "$shell",
        comment => "$comment",
        noop    => $readonly,
     }
  }

  else {
    user {
      "$user":
        ensure  => "$ensure",
        gid     => "$gid",
        home    => "$home",
        shell   => "$shell",
        comment => "$comment",
        noop    => $readonly,
     }
   }

   exec {
    "${user}_homedir":
      path        => "$bin",
      command     => "mkdir -p $home ; chown $user.$gid $home",
      refreshonly => true,
      noop        => $readonly,
      subscribe   => User["$user"]
  }

  if $expires != true {
    exec {
      "${user}_password_expiry":
       path      => "$bin",
       command   => "chage -I -1 -m 0 -M -1 -E -1 ${user}",
       unless    => "chage -l $user | grep -i 'password expires' | grep never",
       noop      => $readonly,
       subscribe => User["$user"]
    }
  }

  if $cronaccess != false {
    exec {
      "${user}_cronallow":
        path      => "$bin",
        command   => "echo ${user} >> /etc/cron.allow",
        unless    => "grep -q $user /etc/cron.allow",
        noop      => $readonly,
        subscribe => User["$user"]
    }

    exec {
      "${user}_accessconf":
        path      => "$bin",
        command   => "sh /usr/local/bin/ucm-access.conf.setup.sh",
        noop      => $readonly,
        subscribe => User["$user"]
    }
  }
}

