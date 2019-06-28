# This is a detached class not in the execution order in init.pp.
# This class is meant to be inlcuded in a foreman hostgroup and manually
# append a user name to the cron allow file created below.
# Puppet will not manage the cron allow file after its first creation.

# This class is considered legacy and should be deprecated soon.

class tda::cronallow {
  file {
    '/etc/cron.allow':
      ensure  => 'present',
      owner   => 'root',
      group   => 'root',
      replace => 'false'
  }

  pam::access {
    'cron':
      permission => '+',
      entity     => 'ALL',
      origin     => 'cron',
      priority   => '10',
      require    => File['/etc/cron.allow']
  }
}
