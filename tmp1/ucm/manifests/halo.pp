class ucm::halo { 

  class {
    'ucm::halo::packages':
  }

  class {
    'ucm::halo::limits':
  }

  class {
    'ucm::halo::kernelparams':
  }

  class {
    'ucm::halo::directories':
  }

  class {
    'ucm::halo::cron':
  }

  class {
    'ucm::halo::shares':
  }

  class {
    'ucm::halo::commands':
      require => [
        Class['ucm::halo::packages'],
        Class['ucm::halo::limits'],
        Class['ucm::halo::kernelparams'],
        Class['ucm::halo::directories'],
        Class['ucm::halo::cron'],
        Class['ucm::halo::shares'],
      ]
  }
}
