define ucm::custom::packages (
  $package     = $title,
  $ensure      = 'nodef',
  $state       = $ensure,
  $readonly    = true,
  $onlyiftrue  = 'nullval',
  $onlyiffalse = 'nullval',
  $msg_onlyif  = "Skipping \"$title\".  Your \"onlyif\" param for package \"$title\" does not = either \"true\" or \"false\".",

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

  if $onlyifparams == 'enabled' {
    if $onlyifparamset != 'good' {
      notify { "msg_onlyifskip_${package}": message => "$msg_onlyif" } 
    }
    else {  
      package {
        "$package":
          ensure => "$state",
          noop   => $ro,
      }
    }
  }
  
  else {
    package {
      "$package":
        ensure => "$state",
        noop   => $ro,
    }
  }
}
