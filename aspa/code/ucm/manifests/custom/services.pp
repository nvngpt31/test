define ucm::custom::services (
  $service      = $title,
  $defined      = 'false',
  $state        = 'nodef',
  $subscribe_to = 'nofile',

){

  if $service == 'blank' {
    #    notify {
    #  'msg_svc_blank':
    #    message => '...NO SERVICES TO MANAGE AT THIS TIME'
    #}
  }

  else {
    if $subscribe_to != 'nofile' {
      service {
        "$service":
          ensure    => "$state",
          subscribe => File["$subscribe_to"]
      }
    }

    else {
      service {
        "$service":
          ensure => $state
      }
    }
  }
}
