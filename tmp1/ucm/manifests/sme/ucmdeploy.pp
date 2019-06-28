class ucm::sme::ucmdeploy (
){

  file {
    '/var/www/cgi-bin/ucmdeploy.cgi':
      ensure  => 'present',
      mode    => '0755',
      content => template('ucm/masters/ucmdeploy.cgi.erb')
  }

}
