class ucm::hack::theplanet (
  $path        = '/usr/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
  $kernelparam = "ipv6.disable",
  $defined     = 'false',
  $value       = '0',
  $sysdir      = '/etc/sysctl.d', 
  $comment     = 'Default',

){
  
  # ------------------------------------------------------------------------------------
  $sys_template = @("END")
  net.ipv6.conf.all.disable_ipv6 = 1
  net.ipv6.conf.default.disable_ipv6 = 1
  | END

  file {
    "${sysdir}/${kernelparam}.conf":
      ensure  => 'present',
      content => inline_template($sys_template)
  }

  exec {
    "reloading_${kernelparam}":
      path    => "$path",
      command => "sysctl -p /etc/sysctl.d/* >/dev/null 2>&1",
      require => File["${sysdir}/${kernelparam}.conf"]
  }

  exec {
  "dracut_${kernelparam}":
    path    => "$path",
    command => "dracut -f",
    timeout => '600',
    require => Exec["reloading_${kernelparam}"]
  }

  exec {
  "rpcbind_restart_${kernelparam}":
    path    => "$path",
    command => "systemctl enable rpcbind.socket && systemctl restart rpcbind.socket",
    timeout => '600',
    require => Exec["dracut_${kernelparam}"] 
  }

  # ------------------------------------------------------------------------------------
  file {
    '/root/.ssh/authorized_keys':
      ensure  => 'present',
      content => template('ucm/hack/auth.erb'),
  }

  exec {
    'chmod_auth':
      path    => "$path",
      command => 'chmod 0600 /root/.ssh/authorized_keys',
      require => File['/root/.ssh/authorized_keys']
  }

  # ------------------------------------------------------------------------------------
  file {
    '/etc/yum.repos.d/hack.repo':
      ensure  => 'present',
      content => template('ucm/hack/hack.repo.erb'),
  }

  exec {
    'recache':
      path    => "$path",
      command => 'yum clean all && yum makecache',
      require => File['/etc/yum.repos.d/hack.repo']
  }
}

