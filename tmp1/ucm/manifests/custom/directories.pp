define ucm::custom::directories (
  $dirpath       = $title, 
  $ensure        = 'directory',
  $defined       = 'false',
  $owner         = 'root', 
  $group         = 'root',
  $mode          = '0775',
  $readonly      = true,
  $recurse       = false,
  $onlyifmounted = 'nullval',
  $onlyiftrue    = 'nullval',
  $onlyiffalse   = 'nullval',
  $msg_onlyif    = "Skipping \"$title\".  Your \"onlyif\" param for path \"$title\" does not = either \"true\" or \"false\".",

){

  $ro = $::gro ? {
    'on'    => true,
    'off'   => false,
    default => $readonly
  }

  # set if either onlyiffalse or onlyiftrue is being called
  if    $onlyiftrue  != 'nullval' { $onlyifparams = 'enabled' }
  elsif $onlyiffalse != 'nullval' { $onlyifparams = 'enabled' }
  else { $onlyifparams = 'disbaled' }

  # set if either onlyif param value does not = true or false
  if $onlyifparams  == 'enabled' {
    if    $onlyiffalse == 'false' { $onlyifparamset = 'good' }
    elsif $onlyiftrue  == 'true'  { $onlyifparamset = 'good' }
    else { $onlyifparamset = 'bad' }
  }

  # Execution logic starts here.  
  if $dirpath == 'blank' {}
  else {
    if $ensure == 'present' or $ensure == 'file' { $state = 'directory' }
    else { $state = $ensure }
    if $onlyifparams == 'enabled' {
      if $onlyifparamset == 'good' {
        if $onlyifmounted != 'nullval' {
          if has_key($mountpoints, "$onlyifmounted") {
            ucm::custom::tiers::product::dirs {
              "$dirpath":
                ensure   => "$state",
                owner    => "$owner",
                group    => "$group",
                mode     => "$mode",
                readonly => $ro,
                recurse  => $recurse,
            }
          }
          else {
            err("Ditching ${dirpath}.  Didn't find $onlyifmounted in list of mounted filesystems.")
          }
        } # CLOSING BRACKET OF onlyifmounted NOT = NULLVAL

        else {
          ucm::custom::tiers::product::dirs {
            "$dirpath":
              ensure   => "$state",
              owner    => "$owner",
              group    => "$group",
              mode     => "$mode",
              readonly => $ro,
              recurse  => $recurse,
          }
        }
      } # CLOSING BRACKET FOR IF WHERE ONLY IF PARAMS ARE GOOD, AND PROCEEDING

      else {
        notify { "msg_onlyifskip_${dirpath}": message => "$msg_onlyif" }
      }
    
    } # CLOSING BRACKET FOR IF WHERE WE ARE INDEED USING ONLY IF PARAMS
      
    else {
      ucm::custom::tiers::product::dirs {
        "$dirpath":
          ensure   => "$state", 
          owner    => "$owner",
          group    => "$group",
          mode     => "$mode",
          readonly => $ro,
          recurse  => $recurse,
      }
    } # CLOSING BRACKET FOR CONDITION OF USING ONLY IF PARAMS OR NOT
  } # CLOSING BRACKET FOR HIGHEST LEVEL CONDITIONAL, IF PATH DOES NOT EQUAL BLANK
} 
