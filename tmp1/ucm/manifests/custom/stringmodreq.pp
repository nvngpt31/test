class ucm::custom::stringmodreq {

  package {
    "python":
      ensure => 'installed'
  }

  # for older systems on 2.6.6
  package {
    "python-argparse":
      ensure => 'installed'
  }

  file {
    "/usr/local/bin/ucm-stringmod.py":
      ensure  => 'present',
      mode    => '0755',
      content => template('ucm/bin/ucm-stringmod.py.erb')
  }

}
