class kdump::service {
  service {
    'kdump':
      ensure     => 'running',
      hasstatus  => true,
      hasrestart => true,
      enable     => true,
  }
}
