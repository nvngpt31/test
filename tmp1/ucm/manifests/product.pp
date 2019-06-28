class ucm::product (
){
  tag 'ucm_product'

  contain ucm::sme::main

  if $::product == undef {
    notify {
      'msg_product_notdefined':
        message => "... PRODUCT FACT NOT DEFINED LOCALLY OR IN FOREMAN.  NOT APPLYING PRODUCT TIER."
    }
  }

  else {

    contain ucm::crossversion::cleanup

    class {
      'ucm::product::centrifyzone':
    }

    class {
      'ucm::product::groups':
        require => Class['ucm::product::centrifyzone'] 
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
      'ucm::product::stringmod':
        require => Class['ucm::product::files']
    }

    class {
      'ucm::product::links':
        require => Class['ucm::product::stringmod']
    }

    class {
      'ucm::product::limits':
        require => Class['ucm::product::links']
    }

    class {
      'ucm::product::kernelparams':
        require => Class['ucm::product::limits']
    }

    class {
      'ucm::product::commands':
        require => Class['ucm::product::kernelparams']
    }

    class {
      'ucm::product::services':
        require => Class['ucm::product::kernelparams']
    }
  }
}


