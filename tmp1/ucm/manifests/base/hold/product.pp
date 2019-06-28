class ucm::legacy::product (
){

  if $::product == undef {
    notify {
      'msg_legacy_notdefined':
        message => "... PRODUCT FACT NOT DEFINED LOCALLY OR IN FOREMAN.  BAILING."
    }
  }

  else {
    notify {
      'msg_legacy':
        message => "... MANAGING LEGACY $::product CONFIG."
    }

    class {
      'ucm::legacy::precommands':
        require => Notify['msg_legacy']
    }

    class {
      'ucm::legacy::groups':
        require => Class['ucm::legacy::precommands']
    }

    class {
      'ucm::legacy::users':
        require => Class['ucm::legacy::groups']
    }

    class {
      'ucm::legacy::packages':
        require => Class['ucm::legacy::users']
    }

    class {
      'ucm::legacy::directories':
        require => Class['ucm::legacy::packages']
    }

    class {
      'ucm::legacy::files':
        require => Class['ucm::legacy::directories']
    }

    #class {
    #  'ucm::legacy::links':
    #    require => Class['ucm::legacy::files']
    #}

    class {
      'ucm::legacy::limits':
      #require => Class['ucm::legacy::links']
      require => Class['ucm::legacy::files']
    }

    class {
      'ucm::legacy::kernelparams':
      require => Class['ucm::legacy::limits']
    }

    class {
      'ucm::legacy::commands':
    }
  }
}
