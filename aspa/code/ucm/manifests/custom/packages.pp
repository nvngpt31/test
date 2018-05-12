define ucm::custom::packages (
  $package = $title,
  $defined = 'false',
  $state   = 'nodef',
  $version = 'nodef',

){


  # 6/8/17 - 3:30 pm made this change on the fly given art. is passing whole rpm name 
  $pkg_norpm = regsubst($package, '.rpm', '', 'G')
  $pkgaction = $state ? {
    /(absent|uninstalled|uninstall|removed|erase|erased)/ => 'absent',
    /(present|installed|install)/                         => 'installed',
    'latest'                                              => 'latest',
    default                                               => 'installed',
  }

  if $pkg_norpm == 'blank' {
    # notify {
    #  'msg_pkg_blank':
    #    message => '...NO PACKAGES TO MANAGE AT THIS TIME'
    #}
  }

  else {
    # If the package should be removed
    if $pkgaction == 'absent' {
      package {
        "$pkg_norpm":
          ensure => $pkgaction
      }
    }

    # If the package should be installed with a specific version
    if $pkgaction == 'installed' {
      if $version == 'nodef' {
        package {
          "$pkg_norpm":
            ensure          => "installed",
            install_options => ['--verbose']
        }
      }

      # 6/8/17 - 3:30 pm made this change on the fly incase the mistakenly provide version anyway
      else {
        package {
          "$pkg_norpm":
            ensure  => "installed",
            install_options => ['--verbose']
        }
      }
    }

    # if the package should be installed to latest
    if $pkgaction == 'latest' {
      package {
        "$pkg_norpm":
          ensure => $pkgaction,
          install_options => ['--verbose']
      }
    }
  }
}

