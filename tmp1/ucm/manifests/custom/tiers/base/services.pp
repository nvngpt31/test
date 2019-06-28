define ucm::custom::tiers::base::services (
  $service        = $title,
  $defined        = 'false',
  $state          = 'nodef',
  $subscribe_to   = 'nofile',
  $readonly           = 'true',
  $enable         = 'true',

){
  
  if $service == 'default' {
    notify { 'msg_svc_def': message => "No Services defined for base tier." }
  }
  else {
    if $subscribe_to != 'nofile' {
      service {
        "$service":
          ensure    => "$state",
          noop      => $readonly,
          enable    => $enable,
          subscribe => File["$subscribe_to"],
      }
    }

    else {
      service {
        "$service":
          ensure => $state,
          enable => $enable,
          noop   => $readonly,
      }
    }
  }
}
