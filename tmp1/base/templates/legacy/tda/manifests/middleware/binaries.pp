define tda::middleware::binaries (
  $exec_path  = '/usr/bin:/usr/sbin:/bin',
  # Rebake managing these packages into this defined type
  $dependcies = [ 'tar', 'gzip', 'wget' ],
  $path2tar   = 'http://bldmaster.associatesys.local/urepo/nonpackaged/middleware',
  $middleware = $title,
  $major      = undef,
  $minor      = undef,
  $user       = undef,
  $group      = undef,

){

  ### TARGET DIR
  $target = $middleware ? {
    #'tcserver'  => '/app/tcserver',
    'hq'        => '/app/HQ',
    default     => undef
  }

  ### OWNER - OF TARGET DIR
  $owner = $middleware ? {
    #'tcserver'  => 'tomcat',
    'hq'        => 'tomcat',
    default     => $user,
  }

  ### GROUP - OF TARGET DIR
  $grp = $middleware ? {
    #'tcserver'  => 'users',
    'hq'        => 'users',
    default     => $group,
  }

  ### RPM - TO INSTALL
  case "${middleware}-${major}.${minor}" {
    #'tcserver-3.0': { $rpm = 'puppet-flag-tcserver-3.0-2014.11.25+05.x86_64.rpm' }
    'hq-5.8':       { $rpm = 'puppet-flag-hq-5.8' }
    default:        { $rpm = undef }
  }

  ### STRING - TO QUERY FOR
  case "${middleware}-${major}.${minor}" {
    #'tcserver-3.0': { $chk4rpm = 'puppet-flag-tcserver-3.0' }
    'hq-5.8':       { $chk4rpm = 'puppet-flag-hq-5.8' }
    default:        { $chk4rpm = undef }
  }

  ### TARBALL - TO WGET
  case "${middleware}-${major}-${minor}" {
    #'tcserver-3-0': { $tarball = 'TCServer-3.0.tar.gz' }
    'hq-5-8':       { $tarball = 'hyperic-hqee-agent-5.8.3.tar.gz' }
    default:        { $tarball = undef }
  }

# #########################################################################
# Starting Resources here
  exec {
    "grab_${tarball}":
      path    => $exec_path,
      command => "wget ${path2tar}/${tarball} -O ${target}/${tarball}",
      unless  => "rpm -qa | grep -i ${chk4rpm} >/dev/null 2>&1",
      notify  => Exec["decompress_${tarball}"];

    "decompress_${tarball}":
      path        => $exec_path,
      refreshonly => true,
      command     => "tar -xzf ${target}/${tarball} -C ${target}",
      notify      => Exec["set_perms_${tarball}"];

    "set_perms_${tarball}":
      path        => $exec_path,
      refreshonly => true,
      command     => "chown -R ${user}.${group} ${target}",
      notify      => Exec["remove_${tarball}"];

    "remove_${tarball}":
      path        => $exec_path,
      refreshonly => true,
      command     => "rm -f ${target}/${tarball}",
      notify      => Exec["install_rpm_${rpm}"];

    "install_rpm_${rpm}":
      path        => $exec_path,
      refreshonly => true,
      command     => "yum install -y ${rpm} > /dev/null";
  }
}

