define ucm::custom::users (
  $user          = $title,
  $uid           = 'null',
  $gid           = 'users',
  $home          = "/home/${user}",
  $shell         = '/bin/bash',
  $comment       = "Puppet Managed System User",
  $ensure        = 'present',
  $bin           = lookup('execpath'),
  $expires       = true,
  $cronaccess    = false,
  $adignore      = false,
  $knownusers    = $::knownusers,
  $localusers    = $::localusers,
  $localoverride = false,
  $readonly      = true,
  $onlyiftrue    = 'nullval',
  $onlyiffalse   = 'nullval',  
  $msg_onlyif    = "Skipping \"$user\".  Your \"onlyif\" param for user \"$user\" does not = either \"true\" or \"false\".",


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
  if $child == 'p3' {
    if $onlyifparams == 'enabled' {
      if $onlyifparamset != 'good' {
        notify { "msg_onlyifskip_${tagname}": message => "$msg_onlyif" } 
      }
      else {      
        notice("Server is P3, voiding additional P5 Logic.")
        ucm::custom::tiers::product::users {
          "$user":
            ensure     => $ensure,
            uid        => $uid,
            gid        => $gid,
            home       => $home,
            shell      => $shell,
            comment    => $comment,
            bin        => $bin,
            expires    => $expires,
            cronaccess => $cronaccess,
            adignore   => $adignore,
            readonly   => $ro,
        }
      }    
    }
    else {
      notice("Server is P3, voiding additional P5 Logic.")
      ucm::custom::tiers::product::users {
        "$user":
          ensure     => $ensure,
          uid        => $uid,
          gid        => $gid,
          home       => $home,
          shell      => $shell,
          comment    => $comment,
          bin        => $bin,
          expires    => $expires,
          cronaccess => $cronaccess,
          adignore   => $adignore,
          readonly   => $ro,
      }
    }
  }

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # This is the else that belongs to the first p3 if
  else {

    # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
    if $onlyifparams == 'enabled' {
      if $onlyifparamset != 'good' {
        notify { "msg_onlyifskip_${tagname}": message => "$msg_onlyif" } 
      }
      else {
        if $user == 'nulluser' or $user == 'platform_user' or $user == 'void' {}
              
        else {
          if $user in $localusers and $localoverride == false {
            notify { "user $user exists, and is local.  Not managing unless overridden.": }
          }
               
          elsif $user in $localusers and $localoverride == true {
            notify { "user $user exists, and is local, but override = true so will manage.": }
                
            ucm::custom::tiers::product::users {
              "$user":
                ensure     => $ensure,
                uid        => $uid,
                gid        => $gid,
                home       => $home,
                shell      => $shell,
                comment    => $comment,
                bin        => $bin,
                expires    => $expires,
                cronaccess => $cronaccess,
                adignore   => $adignore,
                readonly   => $ro,
            }
          }
               
          elsif $user in $knownusers {
            notify { "user $user exists, and is managed in AD.  Not managing user at all.": }
          }
                
          else {
            ucm::custom::tiers::product::users {
              "$user":
                ensure     => $ensure,
                uid        => $uid,
                gid        => $gid,
                home       => $home,
                shell      => $shell,
                comment    => $comment,
                bin        => $bin,
                expires    => $expires,
                cronaccess => $cronaccess,
                adignore   => $adignore,
                readonly   => $ro,
            }
          }
        }
      } # This is the else belonging to the "your onlyif param = the expected value, proceeding" check  
    } # This is the closing bracket of the if where "one of the only if's were provided in the yaml, proceeding".

    # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
    # This is the else where there were no "only if" params provided in the yaml.
    else {
      if $user == 'nulluser' or $user == 'platform_user' or $user == 'void' {}

      else {
        if $user in $localusers and $localoverride == false {
          notify { "user $user exists, and is local.  Not managing unless overridden.": }
        }

        elsif $user in $localusers and $localoverride == true {
          notify { "user $user exists, and is local, but override = true so will manage.": }

          ucm::custom::tiers::product::users {
            "$user":
              ensure     => $ensure, 
              uid        => $uid,
              gid        => $gid,
              home       => $home,
              shell      => $shell, 
              comment    => $comment, 
              bin        => $bin,
              expires    => $expires, 
              cronaccess => $cronaccess, 
              adignore   => $adignore,
              readonly   => $ro,
          }
        }

        elsif $user in $knownusers {
          notify { "user $user exists, and is managed in AD.  Not managing user at all.": } 
        }

        else {
          ucm::custom::tiers::product::users {
            "$user":
              ensure     => $ensure,
              uid        => $uid,
              gid        => $gid,
              home       => $home,
              shell      => $shell,
              comment    => $comment,
              bin        => $bin,
              expires    => $expires,
              cronaccess => $cronaccess,
              adignore   => $adignore,
              readonly   => $ro,
          }
        }
      }
    } # This is the closing bracket of the else belonging to the onlyif check, where there were no only if facts provided in the yaml.
  } # This is the closing bracket of the highest else, the p3 check.
}
