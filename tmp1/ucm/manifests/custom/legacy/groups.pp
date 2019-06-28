define ucm::custom::legacy::groups (
  $group   = $title,
  $gid     = 'null',
  $ensure  = 'present',

){

  if $::is_halo == 'true' { 
  
    notify {
      "${group}_denied":
        message => "...MANAGING LOCAL GROUPS ON HALO MACHINES NOT CURRENTLY ALLOWED, FAIELD TO CONFIGURE ${group}" 
    }
  }

  else { 

    if $gid == 'null' {

      group {
        "$group":
          ensure => "$ensure",
      }
    }

    else {
      group {
        "$group":
          ensure => "$ensure",
          gid    => "$gid"
      }
    }
  }
}
