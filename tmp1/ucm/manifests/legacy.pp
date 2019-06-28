class ucm::legacy (
){
  include ucm::stages
  tag 'ucm_legacy'

  contain ucm::crossversion::utilities

  class {
    "ucm::crossversion::cleanup":
      stage => 'pre'
  }

  if $::legacy_testing == 'true' {
    class {
      'ucm::legacy::provisioning':
        stage => 'pre'
    }
  }

  class {
    'ucm::legacy::os':
  }

  if $::product == undef {
  }

  else {
    class {
      'ucm::legacy::product':
        require => Class['ucm::legacy::os']
    }
  }
}

