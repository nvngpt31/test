class kdump::config {
    kernel_parameter { "crashkernel":
      ensure   => present,
      value => "auto",
  }

  file {
    '/etc/kdump.conf':
      owner   => root,
      group   => root,
      content => template('kdump/kdump.conf.erb'),
      notify  => Service['kdump'];

    '/etc/sysconfig/kdump':
      owner   => root,
      group   => root,
      content => template('kdump/kdump.erb'),
      notify  => Service['kdump'];
  }
}
