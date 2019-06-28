define ucm::custom::sysctl (
  $path        = 'nullval',
  $param       = $title,
  $value       = 'nullval',
  $shouldbe    = 'nullval',
  $readonly    = true,
  $onlyiftrue  = 'nullval',
  $onlyiffalse = 'nullval',
  $msg_onlyif  = "Skipping \"$title\".  Your \"onlyif\" param did not interpolate to either \"true\" or \"false\".",

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
  if $param == 'nullval' {}

  else {
    if $onlyifparams == 'enabled' {
      if $onlyifparamset != 'good' {
        notify { "msg_onlyifskip_${param}": message => "$msg_onlyif" } 
      }

      else {
        ucm::custom::sysctlmanage {
          "$param":
            path     => "$path",
            value    => "$value",
            readonly => $ro, 
        }
      }
    }
       
    else { 
      ucm::custom::sysctlmanage {
        "$param":
          path     => "$path",
          value    => "$value",
          readonly => $ro,
      }
    }
  }
}
