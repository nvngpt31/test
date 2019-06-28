class ucm::custom::centrifyzonereq {

  file {
    "/opt/ucm":
      ensure  => 'directory',
      mode    => '700';
    "/opt/ucm/bin":
      ensure  => 'directory',
      mode    => '700',
      require => File["/opt/ucm"];
    "/opt/ucm/bin/private":
      ensure  => 'directory',
      mode    => '700',
      require => File["/opt/ucm/bin"];
    "/opt/ucm/bin/private/ucm-centrifyzone.py":
      ensure  => 'present',
      mode    => '700',
      content => template('ucm/bin/ucm-centrifyzone.py.erb'),
      require => File["/opt/ucm/bin/private"];
  }


}
