class ucm::sme::masters (
){

  file {
    '/etc/puppetlabs/code/env':
      ensure  => 'present',
      content => template('ucm/masters/env.erb')
  }

  file {
    '/usr/local/bin/ucm-class-masters':
      ensure  => 'present',
      mode    => '0755',
      content => template('ucm/masters/ucm-class-masters.erb')
  }
}
