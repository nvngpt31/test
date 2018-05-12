class ucm::tools {
  tag 'ucm_tools'

  if $::smeucmtool == undef {
  }

  else {
  $tool             = "${::smeucmtool}"
  $tool_groups      = "${smeucmtool}::groups"
  $tool_users       = "${smeucmtool}::users"
  $tool_packages    = "${smeucmtool}::packages"
  $tool_directories = "${smeucmtool}::directories"
  $tool_files       = "${smeucmtool}::files"
  $tool_cmds        = "${smeucmtool}::cmds"
  
  notify {
    'msg_cfgtool':
      message => "... CONFIGURING $smeucmtool"
  }

  ucm::custom::tools::groups {
    "$tool":
      lookupitem => "$tool_groups",
      require    => Notify['msg_cfgtool']
  }

  ucm::custom::tools::users {
    "$tool":
      lookupitem => "$tool_users",
      require    => Ucm::Custom::Tools::Groups["$tool"]
  }

  ucm::custom::tools::packages {
    "$tool":
      lookupitem => "$tool_packages",
      require    => Ucm::Custom::Tools::Users["$tool"]
  }

  ucm::custom::tools::directories {
    "$tool":
      lookupitem => "$tool_directories",
      require    => Ucm::Custom::Tools::Packages["$tool"]
  }

  ucm::custom::tools::files {
    "$tool":
      lookupitem => "$tool_files",
      require    => Ucm::Custom::Tools::Directories["$tool"]
  }

  ucm::custom::tools::cmds {
    "$tool":
      lookupitem => "$tool_cmds",
      require    => Ucm::Custom::Tools::Files["$tool"]
  }
}
}
