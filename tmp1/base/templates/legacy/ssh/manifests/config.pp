class ssh::config {
  sshd_config {
    'Protocol':
      ensure => present,
      value  => $ssh::protocol,
      notify => Service['sshd'];

    'X11Forwarding':
      ensure => present,
      value  => $ssh::x11forwarding,
      notify => Service['sshd'];

    'IgnoreRhosts':
      ensure => present,
      value  => $ssh::ignorerhosts,
      notify => Service['sshd'];


    'HostbasedAuthentication':
      ensure => present,
      value  => $ssh::hostbasedauthentication,
      notify => Service['sshd'];

    'PermitRootLogin':
      ensure => present,
      value  => $ssh::permitrootlogin,
      notify => Service['sshd'];

    'PermitEmptyPasswords':
      ensure => present,
      value  => $ssh::permitemptypasswords,
      notify => Service['sshd'];

    'Banner':
      ensure => present,
      value  => $ssh::banner,
      notify => Service['sshd'];

    'PrintMotd':
      ensure => present,
      value  => $ssh::printmotd,
      notify => Service['sshd'];
  }

  ssh_authorized_key {
    'root-global@20110819':
      ensure => present,
      user   => root,
      type   => 'ssh-rsa',
      key    => 'AAAAB3NzaC1yc2EAAAABIwAAAQEAqcHER2QptprFu9lOgkeyB88aEe2J/Kw1FELvNspAniXjdb7Oqcm68rRf7ok2S9Kr5JNcneeDRqRmEfn8VjRcFsHkySRGKKaIGETPMiHzQ8gpNnXYq2/DJrIhUt4m1bF4/JF6VWv+usWcWOYYZN6A8M8WylonMwtDAfGbru1D9uQ78d8IBXyn0YlNTkAMejqLYJdaEgvYVPLLARUbeyq9olfItjkubcSds0/cjTVTbKAXPGyimoorW1/+wocl1sCfcjSYTYG5lh0zlzZ6Sqgw9jijOdPsdIW25I9el28CCt4htmAXVeOYTImF2UZ+B4GPCgqi5adYZXcIRzmM6boMtw==',
      target => '/root/.ssh/authorized_keys';
  }
}
