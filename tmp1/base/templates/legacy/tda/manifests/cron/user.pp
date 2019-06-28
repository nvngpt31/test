define tda::cron::user (
  $path  = '/usr/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
  $conf  = '/etc/security/access.conf',
  $file  = '/etc/cron.allow',
  $user  = $title,
  $all   = '+:ALL:cron',
  $root  = '-:ALL EXCEPT root (ulse):LOCAL',
  $ensure,

){
  # I know.  This is not how we manage files in Puppet.  But this ones small and
  # behaves the exact same way as a file resource.
  exec {
    "${user}_cron_file":
      path    => "$path",
      command => "touch /etc/cron.allow",
      unless  => "test -f /etc/cron.allow"
  }

  exec {
    "${user}_nuke":
      path    => "$path",
      command => "echo > $conf",
  }

  exec {
    "${user}_all":
      path    => "$path",
      command => "echo \"$all\" > $conf",
      require => Exec["${user}_nuke"]
  }

  exec {
    "${user}_except":
      path    => "$path",
      command => "echo \"$root\" >> $conf",
      require => Exec["${user}_all"]
  }

  exec {
    "${user}_allow":
      path    => "$path",
      command => "echo $user >> $file",
      unless  => "grep -q $user $file"
  }

  #file_line {
  #  "${user}":
  #    ensure  => 'present',
  #    path    => "${file}",
  #    line    => "${user}",
  #}
}


