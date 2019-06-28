class ucm::product::main (
){

  notify {
    'MSGPRODUCT':
      message => 'MANAGING PRODUCT CONFIGURATIONS IF ANY'
  }

  class { 
    'ucm::product::groups': 
  }

  class { 
    'ucm::product::users':
      require => Class['ucm::product::groups']
  }

  class { 
    'ucm::product::packages':
      require => Class['ucm::product::users']
  }

  class { 
    'ucm::product::directories':
      require => Class['ucm::product::packages']
  }

  class { 
    'ucm::product::files':
      require => Class['ucm::product::directories']
  }
}
