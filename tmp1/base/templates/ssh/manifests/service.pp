class ssh::service {
  service {
    'sshd':
      ensure     => $ssh::service_ensure,
      name       => $ssh::service_name,
      enable     => $ssh::service_enable,
      hasrestart => $ssh::service_hasrestart,
      hasstatus  => $ssh::service_hasstatus,
  }
}
