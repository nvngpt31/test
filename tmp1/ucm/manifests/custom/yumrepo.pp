define ucm::custom::yumrepo (
  $repo     = $title,
  $enabled  = 'false',
  $gpgkey   = 'absent',
  $gpgcheck = 'false',
  $baseurl  = 'absent',
  $descr    = 'nullval',    

  $readonly    = true,
  $onlyiftrue  = 'nullval',
  $onlyiffalse = 'nullval',  
  $msg_onlyif  = "Skipping \"$title\".  Your \"onlyif\" param for \"$title\" does not = either \"true\" or \"false\".",

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
  if $repo == 'nullval' {}
  else {
    # Execution logic starts here.  
    if $onlyifparams == 'enabled' {
      if $onlyifparamset != 'good' {
        notify { "msg_onlyifskip_${title}": message => "$msg_onlyif" } 
      }
      else {  
        yumrepo { 
          "$repo":
            descr    => "$descr", 
            baseurl  => "$baseurl",
            enabled  => $enabled,
            gpgcheck => $gpgcheck,
            gpgkey   => $gpgkey,
        }
      }
    }
     
    else {
      yumrepo {
        "$repo":
          descr    => "$descr",
          baseurl  => "$baseurl",
          enabled  => $enabled,
          gpgcheck => $gpgcheck,
          gpgkey   => $gpgkey,
      }
    }
  }
}
