class ucm::legacy::os {
  tag 'ucm_legacy_os'

  if $::ucmos == undef {
    notify {
      'msg_noos':
        message => '... no operating system fact "ucmos" set.'
    }
  }

  else {
    
    $os              = "${::ucmos}"
    $os_groups       = "${::ucmos}::groups"
    $os_users        = "${::ucmos}::users"
    $os_packages     = "${::ucmos}::packages"
    $os_directories  = "${::ucmos}::directories"
    $os_files        = "${::ucmos}::files"
    $os_stringmod    = "${::ucmos}::stringmod"
    $os_sysctl       = "${::ucmos}::sysctl"
    $os_links        = "${::ucmos}::links"
    $os_limits       = "${::ucmos}::limits"
    $os_cron         = "${::ucmos}::cron"
    $os_commands     = "${::ucmos}::commands"
    $os_services     = "${::ucmos}::services"
    
    ucm::custom::os::groups {
      "$os":
        lookupitem => "$os_groups",
        before     => Ucm::Custom::Os::Commands["$os"],
    }

    ucm::custom::os::users {
      "$os":
        lookupitem => "$os_users",
        before     => Ucm::Custom::Os::Commands["$os"],
    }

    ucm::custom::os::packages {
      "$os":
        lookupitem => "$os_packages",
        before     => Ucm::Custom::Os::Commands["$os"],
        require    => Ucm::Custom::Os::Groups["$os"],
    }

    ucm::custom::os::directories {
      "$os":
        lookupitem => "$os_directories",
        before     => Ucm::Custom::Os::Commands["$os"],
    }

    ucm::custom::os::files {
      "$os":
        lookupitem => "$os_files",
        before     => Ucm::Custom::Os::Commands["$os"],
        require    => Ucm::Custom::Os::Directories["$os"],
    }

    class { 
      'ucm::legacy::stringmod': 
        lookupitem => $os_stringmod,
        require    => Ucm::Custom::Os::Files["$os"],
    }

    class {
      'ucm::legacy::sysctl':
        lookupitem => $os_sysctl,
        require    => Ucm::Custom::Os::Files["$os"],
    }

    ucm::custom::os::services {
      "$os":
        lookupitem => "$os_services",
        # require    => Ucm::Custom::Os::Files["$os"],
        require    => Class["ucm::legacy::stringmod"],
        before     => Ucm::Custom::Os::Commands["$os"],
    }

    ucm::custom::os::commands {
      "$os":
        lookupitem => "$os_commands",
    }
  }
}
