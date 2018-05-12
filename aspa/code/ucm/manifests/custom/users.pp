define ucm::custom::users (
  $user      = $title, 
  $uid       = 'null',
  $gid       = 'null',
  $home      = "/home/${user}",
  $shell     = '/bin/bash',
  $comment   = "Puppet Managed System User",
  $ensure    = 'present',
  $bin       = lookup('execpath'),
  $expires   = true,

){

  if $::is_halo == 'true' { 
  
    notify {
      "${user}_denied":
        message => "...MANAGING LOCAL USERS ON HALO MACHINES NOT CURRENTLY ALLOWED, FAIELD TO CONFIGURE ${user}" 
    }
  }

  else {

    user {
      "$user":
        ensure  => "$ensure",
        uid     => "$uid",
        gid     => "$gid",
        home    => "$home",
        shell   => "$shell",
        comment => "$comment",
    }

    #if $uid != 'null' {
    #  exec {
    #    "chuid_${user}":
    #      path    => "$bin",
    #      command => "usermod -u $uid $user ",
    #      unless  => "id -u $user | grep $uid ",
    #      before  => Exec["${user}_homedir"]
    #  }
    #}

    #if $gid != 'null' {
    #  exec {
    #    "chgid_${user}":
    #      path    => "$bin",
    #      command => "usermod -g $gid $user ",
    #      unless  => "id -g $user | grep $uid ",
    #      before  => Exec["${user}_homedir"]
    #  }
    #}
    
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

