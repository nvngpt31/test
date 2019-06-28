class ucm::base::main (
  $runbase = 'false',

){
  tag 'ucm_base_os'

  if $::runbase == 'true' or $::basetesting == 'true' {

    ucm::custom::createfact {
      'runbase':
        value => 'false'
    } 

    if $::ucmos == undef {
      notify { 'msg_noos':  message => '... no operating system fact "ucmos" set.' }
    }

    else {
      $os              = "${::ucmos}"
      $os_filediff     = "${::ucmos}::filediff"
      $os_sysctl       = "${::ucmos}::sysctl::files"
      $os_groups       = "${::ucmos}::groups"
      $os_users        = "${::ucmos}::users"
      $os_packages     = "${::ucmos}::packages"
      $os_directories  = "${::ucmos}::directories"
      $os_files        = "${::ucmos}::files"
      $os_links        = "${::ucmos}::links"
      $os_limits       = "${::ucmos}::limits"
      $os_cron         = "${::ucmos}::cron"
      $os_commands     = "${::ucmos}::commands"
      $os_services     = "${::ucmos}::services"
    
      ucm::custom::base::filediff {
        "$os":
          lookupitem => "$os_filediff",
      }

      ucm::custom::base::sysctl {
        "$os":
          lookupitem => "$os_sysctl",
      }

      ucm::custom::base::groups {
        "$os":
          lookupitem => "$os_groups",
          # require    => Ucm::Custom::Base::Sysctl["$os"]
      }

      ucm::custom::base::users {
        "$os":
          lookupitem => "$os_users",
          require    => Ucm::Custom::Base::Groups["$os"]
      }

      ucm::custom::base::packages {
        "$os":
          lookupitem => "$os_packages",
          require    => Ucm::Custom::Base::Users["$os"]
      }

      ucm::custom::base::directories {
        "$os":
          lookupitem => "$os_directories",
          require    => Ucm::Custom::Base::Packages["$os"]
      }

      ucm::custom::base::files {
        "$os":
          lookupitem => "$os_files",
          require    => Ucm::Custom::Base::Directories["$os"]
      }
    
      ucm::custom::base::services {
        "$os":
          lookupitem => "$os_services",
          require    => Ucm::Custom::Base::Files["$os"]
      }
    }
  }

  else {
    notify { "Not running base class on node $::hostname": } 
  }
}
