define ucm::custom::files (
  $path          = $title,
  $defined       = 'false',
  $owner         = 'root',
  $group         = 'root',
  $mode          = '0755',
  $replace       = 'true',
  $ensure        = 'present',
  $template      = 'nodef',
  $readonly      = true,
  $onlyifmounted = 'nullval',
  $onlyiftrue    = 'truedefnull',
  $onlyiffalse   = 'falsedefnull',
  $modparams,

){

  $ro = $::gro ? {
    'on'    => true,
    'off'   => false,
    default => $readonly
  }


  if $path == 'blank' {
  }

  else {

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    if $onlyiftrue != 'truedefnull' {
      if $onlyiftrue == 'true' {
        # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
        if $onlyifmounted != 'nullval' {
          if has_key($mountpoints, "$onlyifmounted") {
            ucm::custom::tiers::product::files {
              "$path":
                ensure    => "$ensure",
                owner     => "$owner",
                group     => "$group",
                mode      => "$mode",
                template  => "$template",
                readonly  => $ro,
                modparams => "$modparams", 
            }
          }
          else {
            err("Ditching ${path}.  Didn't find $onlyifmounted in list of mounted filesystems.")
          }
        }
        # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
      }
      else {
        notice("Skipping directory ${path}. In the yaml for this server, the fact you provided to parameter \"onlyiftrue\" does not = true.")
      }
    }

    elsif $onlyiffalse != 'falsedefnull' {
      if $onlyiffalse == 'false' {
        # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
        if $onlyifmounted != 'nullval' {
          if has_key($mountpoints, "$onlyifmounted") {
            ucm::custom::tiers::product::files {
              "$path":
                ensure    => "$ensure",
                owner     => "$owner",
                group     => "$group",
                mode      => "$mode",
                replace   => "$replace",
                template  => "$template",
                readonly  => $ro,
                modparams => $modparams, 
            }
          }
          else {
            err("Ditching ${path}.  Didn't find $onlyifmounted in list of mounted filesystems.")
          }
        }
        # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
      }
      else {
        notice("Skipping directory ${path}. In the yaml for this server, the fact you provided to parameter \"onlyiftrue\" does not = true.")
      }
    }

    else {
      # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
      if $onlyifmounted != 'nullval' {
        if has_key($mountpoints, "$onlyifmounted") {
          ucm::custom::tiers::product::files {
            "$path":
              ensure    => "$ensure",
              owner     => "$owner",
              group     => "$group",
              mode      => "$mode",
              replace   => "$replace",
              readonly  => $ro,
              template  => "$template",
              modparams => $modparams, 
          }
        }
        else {
          err("Ditching ${path}.  Didn't find $onlyifmounted in list of mounted filesystems.")
        }
      }
      # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
      else {
        ucm::custom::tiers::product::files {
          "$path":
            ensure    => "$ensure",
            owner     => "$owner",
            group     => "$group",
            mode      => "$mode",
            replace   => "$replace",
            readonly  => $ro,
            template  => "$template",
            modparams => $modparams, 
        }
      }
    }
  }
}


