class ucm::product (
){
  tag 'ucm_product'

  if $::product == undef {
    notify {
      'msg_product_notdefined':
        message => "... PRODUCT FACT NOT DEFINED LOCALLY OR IN FOREMAN.  NOT APPLYING PRODUCT TIER."
    }
  }

  else {

    notify {
      'msg_product':
        message => "... MANAGING PRODUCT TIER CONFIG IF ANY."
    }

    class { 
      'ucm::product::groups': 
        require => Notify['msg_product'] 
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

    class { 
      'ucm::product::links': 
        require => Class['ucm::product::files']
    }

    class { 
      'ucm::product::limits': 
        require => Class['ucm::product::links']
    }
  }
}

