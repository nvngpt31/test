class ucm::test (
){

  file {
    '/tmp/myfile':
      ensure  => 'present',
      content => epp('ucm/myfile.epp')
  }

}

