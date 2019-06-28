define ucm::custom::legacy::files (
  $path            = $title,
  $owner           = 'root',
  $group           = 'root',
  $mode            = '0755',
  $replace         = 'true',
  $ensure          = 'present',
  $recurse         = 'false',
  $template        = 'nodef',
  $restart_service = 'false',
  $readonly        = 'true',
  $onlyiftrue      = 'nullval',
  $onlyiffalse     = 'nullval',  
  $msg_onlyif      = "Skipping \"$title\".  Your \"onlyif\" param for file \"$title\" does not = either \"true\" or \"false\".",

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
  

  if $path == 'blank' {}
  else {
    if $onlyifparams == 'enabled' {
      if $onlyifparamset != 'good' {
        notify { "msg_onlyifskip_${title}": message => "$msg_onlyif" } 
      }
      else {  
        ucm::custom::tiers::base::legacyfiles {
          "$path":
            owner           => "$owner", 
            group           => "$group",
            mode            => "$mode",
            replace         => $replace, 
            ensure          => "$ensure",
            recurse         => $recurse,
            template        => "$template",
            restart_service => $restart_service,
            readonly        => $readonly,
        }
      }
    }
    else {
      ucm::custom::tiers::base::legacyfiles {
        "$path":
          owner           => "$owner",
          group           => "$group",
          mode            => "$mode",
          replace         => $replace,
          ensure          => "$ensure",
          recurse         => $recurse,
          template        => "$template",
          restart_service => $restart_service,
          readonly        => $readonly,
      }
    }
  }
}
