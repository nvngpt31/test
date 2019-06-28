class tda::tdaconfigs (
  $execpath = '/usr/ucb:/usr/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'

){

  group { 'users':
    gid       => 103,
    allowdupe => true,
  }

  file {
    '/etc/sudoers.d/taddm_sudo':
      ensure  => 'present',
      owner   => 'root',
      group   => 'root',
      content => template('tda/taddm_sudo.erb');

    '/etc/tda-release':
      content => "${::osfamily}-${::operatingsystemrelease}.${::arch}-${tda::tdamajor}",
      owner   => root,
      group   => root,
      mode    => '0644';

    '/etc/crontab':
      content => template('tda/crontab.erb'),
      owner   => root,
      group   => root;

    '/etc/anacrontab':
      content => template('tda/anacrontab.erb'),
      owner   => root,
      group   => root,
      mode    => '0600';

    '/etc/issue':
      content => template('tda/issue.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644';

    '/etc/issue.net':
      content => template('tda/issue.net.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644';

    '/etc/default/useradd':
      source => 'puppet:///modules/tda/useradd',
      owner  => root,
      group  => root,
      mode   => '0600';

    '/etc/rc3.d/S97configure_TDA_puppetstyle':
      ensure => 'absent',
      owner  => root,
      group  => root,
      mode   => '0644';

    '/etc/profile.d/custom.sh':
      source => 'puppet:///modules/tda/custom.sh',
      owner  => root,
      group  => root,
      mode   => '0644';

    '/etc/login.defs':
      source => 'puppet:///modules/tda/login.defs',
      owner  => root,
      group  => root,
      mode   => '0644';

    '/etc/yum/pluginconf.d/subscription-manager.conf':
      source => 'puppet:///modules/tda/subscription-manager.conf',
      owner  => root,
      group  => root,
      mode   => '0644';

    '/etc/netconfig':
      content => template('tda/netconfig.erb'),
      owner   => root,
      group   => root,
      mode    => '0644';

    '/root/.bash_profile':
      content => template('tda/bash_profile.erb'),
      owner   => root,
      group   => root,
      mode    => '0644';
  }

  if $::operatingsystemmajrelease == '7' {

    file {
      '/etc/dconf':
        ensure => 'directory',
    }

    file {
      '/etc/dconf/db':
        ensure  => 'directory',
        require => File['/etc/dconf']
    }

    file {
      '/etc/dconf/db/local.d':
        ensure  => 'directory',
        require => File['/etc/dconf/db']
    }

    file {
      '/etc/dconf/db/local.d/00-disable-CAD':
        source  => 'puppet:///modules/tda/00-disable-CAD',
        owner   => root,
        group   => root,
        mode    => '0644',
        require => File['/etc/dconf/db/local.d']
    }

    file {
      '/etc/systemd/system/ctrl-alt-del.target':
        ensure  => 'link',
        target  => '/dev/null',
        require => File['/etc/dconf/db/local.d/00-disable-CAD']
    }

  } else {

    file {
      '/etc/init/control-alt-delete.conf':
        source => 'puppet:///modules/tda/control-alt-delete.conf',
        owner  => root,
        group  => root,
        mode   => '0644';
    }
  }

  sudo::conf {
    'admins':
      content => "%ulse   ALL=(ALL)   ALL";

    'cyberark':
      content => "zcyberarkunix ALL=(root) /usr/bin/passwd root";
  }

  file_line {
    'rootpam':
      path => '/etc/security/access.conf',
      line => '-:ALL EXCEPT root (ulse):LOCAL'
  }

  class { 'tda::sudoapp': }


  exec {
    'rootwheel':
      path    => $execpath,
      command => "usermod -G wheel root",
      unless  => "groups root | grep -q wheel",
  }

  exec {
    'chmodcrontab':
      path    => $execpath,
      command => 'chmod 0644 /etc/crontab',
  }
}
