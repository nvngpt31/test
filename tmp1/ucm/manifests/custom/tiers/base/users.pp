define ucm::custom::tiers::base::users (
  $user             = $title, 
  $uid              = 'null',
  $gid              = 'null',
  $home             = "/home/${user}",
  $shell            = '/bin/bash',
  $comment          = "Puppet Managed System User",
  $ensure           = 'present',
  $bin              = hiera('execpath'),
  $expires          = true,
  $managehome       = 'false',
  $groups           = 'users',
  $ad_ignore        = 'false',
  $readonly             = 'true',

){
  if $user == 'default' {
    notify { 'msg_usr_def': message => "No Users defined for base tier." }
  }
  else {
    user {
      "$user":
        ensure  => "$ensure",
        uid     => "$uid",
        gid     => "$gid",
        home    => "$home",
        shell   => "$shell",
        groups  => "$groups",
        comment => "$comment",
        noop    => "$readonly",
    }

    if $readonly != 'true' {
      exec {
        "${user}_homedir":
          path        => "$bin",
          command     => "mkdir -p $home ; chown $user.$gid $home",
          refreshonly => true,
          subscribe   => User["$user"]
      }
    
      if $expires != true {
        exec {
          "${user}_password_expiry":
            path    => "$bin",
            command => "chage -I -1 -m 0 -M -1 -E -1 ${user}",
            unless  => "chage -l $user | grep -i 'password expires' | grep never",
            subscribe   => User["$user"]
        }
      }
    }
  }
}

