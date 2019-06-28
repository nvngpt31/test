class ucm::tools (
){

  if $::runtools == 'true' {
    tag 'ucm_tools'

    ucm::custom::createfact {
      'runtools':
        value => 'false'
    }

    if $::smeucmtool == undef {
      notify { "Fact smeucmtool is not defined, this not applying anything.": }
    }

    else { 
      $tool             = $::smeucmtool
      $tool_groups      = "${tool}::groups"
      $tool_users       = "${tool}::users"
      $tool_packages    = "${tool}::packages"
      $tool_directories = "${tool}::directories"
      $tool_files       = "${tool}::files"
      $tool_cmds        = "${tool}::cmds"
      $tool_services    = "${tool}::services"
  
      notify {
        'msg_cfgtool':
          message => "... CONFIGURING $tool"
      }

      ucm::custom::tiers::tools::groups {
        "$tool":
          lookupitem => "$tool_groups",
          require    => Notify['msg_cfgtool']
      }

      ucm::custom::tiers::tools::users {
        "$tool":
          lookupitem => "$tool_users",
          require    => Ucm::Custom::Tiers::Tools::Groups["$tool"]
      }

      ucm::custom::tiers::tools::packages {
        "$tool":
          lookupitem => "$tool_packages",
          require    => Ucm::Custom::Tiers::Tools::Users["$tool"]
      }

      ucm::custom::tiers::tools::directories {
        "$tool":
          lookupitem => "$tool_directories",
          require    => Ucm::Custom::Tiers::Tools::Packages["$tool"]
      }

      ucm::custom::tiers::tools::files {
        "$tool":
          lookupitem => "$tool_files",
          require    => Ucm::Custom::Tiers::Tools::Directories["$tool"]
      }

      ucm::custom::tiers::tools::cmds {
        "$tool":
          lookupitem => "$tool_cmds",
          require    => Ucm::Custom::Tiers::Tools::Files["$tool"]
      }
   
      ucm::custom::tiers::tools::services {
        "$tool":
          lookupitem => "$tool_services",
          require    => Ucm::Custom::Tiers::Tools::Cmds["$tool"]
      }
    }
  }

  else {
    notify { "Not running class ucm::tools on this server $::hostname because fact runtools does not = true.": }
  }
}
