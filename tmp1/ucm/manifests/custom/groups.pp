define ucm::custom::groups (
  $group       = $title,
  $gid         = 'null',
  $ensure      = 'present',
  $allowdupe   = false,
  $forcelocal  = false,
  $readonly    = true,
  $onlyiftrue  = 'nullval',
  $onlyiffalse = 'nullval',  
  $msg_onlyif  = "Skipping \"$group\".  Your \"onlyif\" param for group \"$group\" does not = either \"true\" or \"false\".",

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

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Execution logic starts here.  
  if $onlyifparams == 'enabled' {
    if $onlyifparamset != 'good' {
      notify { "msg_onlyifskip_${tagname}": message => "$msg_onlyif" } 
    }
    else {  
      if $gid == 'null' {

        group {
          "$group":
            ensure    => "$ensure",
            allowdupe => "$allowdupe",
            forcelocal => $forcelocal,
            noop      => $ro,
        }
      }

      else {
        group {
          "$group":
            ensure    => "$ensure",
            gid       => "$gid",
            allowdupe => "$allowdupe",
            forcelocal => $forcelocal,
            noop      => $ro,
        }
      }
    }
  }

  else {
    if $gid == 'null' {
      group {
        "$group":
          ensure    => "$ensure",
          allowdupe => "$allowdupe",
          forcelocal => $forcelocal,
          noop      => $ro,
        }
      }
           
    else {
      group {
        "$group":
          ensure    => "$ensure",
          gid       => "$gid",
          allowdupe => "$allowdupe",
          forcelocal => $forcelocal,
          noop      => $ro,
      }
    }
  }
}

