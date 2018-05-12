class ucm::sme::hieraconfig (
){

  file {
    '/usr/local/bin/prodmods':
      ensure  => 'present',
      mode    => '0775',
      content => template('ucm/prodmods.erb')
  }

  file {
    '/etc/puppetlabs/puppet/hiera.yaml':
      ensure  => 'present',
      content => template('ucm/hiera.yaml.erb'),
      require => File['/usr/local/bin/prodmods']
  }
}
