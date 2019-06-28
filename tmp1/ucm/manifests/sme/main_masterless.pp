class ucm::sme::main (
){

  # COMMENT MADE 2/7/2018
  # DEFAULT USER FOR NON ROOT LEVEL THINGS
  # ONCE EVERYTHING IS VETTED OUT WE NEED TO CONVERT THIS TO THE Z UCM ACCOUNT IN CENTRIFY
  user {
    'ucmdefault':
      ensure => 'present'
  }

  if $::product != undef {

    $apps  = lookup('apps')
    $tools = lookup('tools')

    class { 'ucm::sme::hieraconfig': }

    create_resources('ucm::custom::touchapp', $apps)
    create_resources('ucm::custom::touchtool', $tools)

    file {
      '/usr/local/bin/ucm':
        ensure  => 'present',
        mode    => '0755',
        content => template('ucm/ucm.erb')
    }

    ucm::custom::createfact {
      'product_fact_set':
        value  => 'true',
    }
  }

  else {
    notify {
      'msg_blank':
        message => '...PRODUCT NOT DEFINED, SKIPPING.'
    }
   
    ucm::custom::createfact {
      'product_fact_set':
        value   => 'false',
        require => Notify['msg_blank']
    }

  }

}
