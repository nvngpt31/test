define ucm::custom::services (
  $service      = $title,
  $ensure       = 'running',
  $enable       = true,
  $subscribe_to = false,
  $readonly     = true,
  $state        = $ensure,
  $onlyiftrue  = 'nullval',
  $onlyiffalse = 'nullval',  
  $msg_onlyif  = "Skipping \"$title\".  Your \"onlyif\" param for service \"$title\" does not = either \"true\" or \"false\".",


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

  
  if $service == 'blank' or $service == undef or $ensure == false {}
  else {

    if $onlyifparams == 'enabled' {
      if $onlyifparamset != 'good' {
        notify { "msg_onlyifskip_${service}": message => "$msg_onlyif" } 
      }
    
      else {  
        if $subscribe_to != false {
          service {
            "$service":
              ensure    => "$state",
              enable    => $enable,
              noop      => $ro,
              subscribe => File["$subscribe_to"],
            }
          }
                  
        else {
          service {
            "$service":
              ensure  => "$state",
              enable  => $enable,
              noop    => $ro,
          }
        }
      }
    }

    else {
      if $subscribe_to != false {
        service {
          "$service":
            ensure    => "$state",
            enable    => $enable,
            noop      => $ro,
            subscribe => File["$subscribe_to"],
          }
        }
              
      else {
        service {
          "$service":
            ensure  => "$state",
            enable  => $enable,
            noop    => $ro,
        }
      }
    }
  }
}
               
