define ucm::custom::centrifyzone (
  $zone        = $title,
  $domain      = 'nullval',
  $ensure      = 'nullval',
  $readonly    = true,
  $onlyiftrue  = 'nullval',
  $onlyiffalse = 'nullval',  
  $msg_onlyif  = "Skipping AD Zone management for \"$zone\".  Your \"onlyif\" param for centrifyzone \"$zone\" does not = either \"true\" or \"false\".",
  $execpath    = lookup('execpath'),
  $command     = "/opt/ucm/bin/private/ucm-centrifyzone.py -z ${zone} -d ${domain}",
  $timeout     = "600", # 10 minutes

){


  if $ensure == 'nullval' {
    # Do Nothing
  }

  elsif $ensure != 'nullval' and $ensure != 'joined' {
    notify { "msg_mustbe_joined_${zone}": message => "Please set the value for 'ensure' to = 'joined'." }
  }

  else {
    notify { "msg_centzone_${zone}": message => "Checking state of centrify zone." }
   
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
        notify { "msg_onlyifskip_${zone}": message => "$msg_onlyif" } 
      }
  
      else {  
        exec {
          "centrifyzone_for_${zone}":
            path    => "$execpath", 
            command => "$command", 
            # unless  => "$command",
            timeout => "$timeout",
            noop    => "$readonly",
        }
      }
    }

    else {
      exec {
        "centrifyzone_for_${zone}":
          path    => "$execpath", 
          command => "$command", 
          # unless  => "$command",
          timeout => "$timeout",
          noop    => "$readonly",
      }
    }
  }
}

