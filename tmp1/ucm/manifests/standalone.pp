class ucm::standalone {

  #class {
  #  'ucm::standalone::groups':
  #}

  #class {
  #  'ucm::standalone::users':
  #    require => Class['ucm::standalone::groups']
  #}

  class {
    'ucm::standalone::packages':
      #require => Class['ucm::standalone::users']
  }

  #class {
  #  'ucm::standalone::limits':
  #    require => Class['ucm::standalone::packages']
  #}

  #class {
  #  'ucm::standalone::kernelparams':
  #    require => Class['ucm::standalone::limits']
  #}

  class {
    'ucm::standalone::directories':
      require => Class['ucm::standalone::packages']
      #require => Class['ucm::standalone::kernelparams']
  }

  class {
    'ucm::standalone::files':
      require => Class['ucm::standalone::directories']
      #require => Class['ucm::standalone::directories']
  }

  #class {
  #  'ucm::standalone::commands':
  #    require => Class['ucm::standalone::files']
  #}
}
