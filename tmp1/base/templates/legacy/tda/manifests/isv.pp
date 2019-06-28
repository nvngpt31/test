class tda::isv {

  package {
    'ITM6base':
      ensure => installed;
    'tda-capmgt-bpa':
      ensure => installed;
    'BESAgent':
      ensure => installed;
    'ksh':
      ensure => installed;
    'logwatch':
      ensure => absent;
  }

  file {
    '/etc/opt/BESClient':
      ensure  => directory,
      owner   => root,
      group   => root,
      mode    => '0755',
      require => Package['BESAgent'];

    '/etc/opt/BESClient/actionsite.afxm':
      source  => 'puppet:///modules/tda/actionsite.afxm',
      owner   => root,
      group   => root,
      mode    => '0644',
      require => File['/etc/opt/BESClient'];
  }
}
