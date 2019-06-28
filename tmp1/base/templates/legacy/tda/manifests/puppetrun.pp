class tda::puppetrun (
  $enabled = 'false'

){

  if $enabled == 'true' {
    file {
      '/usr/local/bin/tda-puppet-run':
        ensure  => 'present',
        content => template('tda/tda-puppet-run.erb'),
        mode    => '0741'
    }

    cron {
      'cron_scheduled_puppet_run':
        ensure  => 'present',
        command => '/usr/local/bin/tda-puppet-run >/dev/null 2>&1',
        hour    => '18',
        minute  => '00',
        user    => 'root',
        require => File['/usr/local/bin/tda-puppet-run']
      }
  }

  else {
    cron {
      'cron_scheduled_puppet_run':
        ensure  => 'absent',
        command => '/usr/local/bin/tda-puppet-run >/dev/null 2>&1',
        hour    => '18',
        minute  => '00',
        user    => 'root',
      }

    file {
      '/usr/local/bin/tda-puppet-run':
        ensure  => 'absent',
    }
  }
}

