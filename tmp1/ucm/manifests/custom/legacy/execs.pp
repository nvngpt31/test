define ucm::custom::legacy::execs (
  $command      = '/bin/false',
  $tagname      = $title,
  $defined      = 'false',
  $path         = hiera('execpath'),
  $flag         = "/etc/facter/facts.d/flag_${tagname}.txt",
  $runas        = 'root', 
  $requiretag   = "empty",
  $unless       = "/bin/false",       
  $readonly     = true,
  $voidexecs    = 'true', 
  $onlyiftrue  = 'nullval',
  $onlyiffalse = 'nullval',  
  $msg_onlyif  = "Skipping \"$title\".  Your \"onlyif\" param for exec \"$title\" does not = either \"true\" or \"false\".",

){

  $ro = $::gro ? {
    'on'    => true,
    'off'   => false,
    default => $readonly
  }
  
  # --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
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

  # --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  if $tagname == 'blank' or $tagname == 'void' or $tagname == 'ucmdef_cmd' {
  }

  else {
    if $onlyifparams == 'enabled' {
      if $onlyifparamset != 'good' {
        notify { "msg_onlyifskip_${tagname}": message => "$msg_onlyif" } 
      }
                
      else {  
             
        if $requiretag != 'empty' {
          exec {
            "exec_for_$tagname":
              path       => $path,
              user       => $runas,
              command    => "$command",
              noop       => $ro,
              unless     => "$unless",
              require    => Exec["$requiretag"],
          }
        }
            
        else {
          exec {
            "exec_for_$tagname":
              path    => $path,
              user    => $runas,
              command => "$command",
              noop    => $ro,
              unless  => "$unless"
          }
        } 
      }
    }
         
    else {
      if $requiretag != 'empty' {
        exec {
          "exec_for_$tagname":
            path       => $path,
            user       => $runas,
            command    => "$command",
            noop       => $ro,
            unless     => "$unless",
            require    => Exec["$requiretag"],
        }
      }

      else {
        exec {
          "exec_for_$tagname":
            path    => $path,
            user    => $runas,
            command => "$command",
            noop    => $ro,
            unless  => "$unless"
        }
      }
    }
  }
}

