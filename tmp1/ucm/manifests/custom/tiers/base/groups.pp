define ucm::custom::tiers::base::groups (
  $group     = $title,
  $gid       = 'null',
  $ensure    = 'present',
  $allowdupe = 'false',
  $readonly      = 'true',

){
  if $group == 'default' {
    notify { 'msg_grp_def': message => "No Groups defined for base tier." }
  }
  else { 
    if $gid == 'null' {
      group {
        "$group":
          ensure    => "$ensure",
          allowdupe => "$allowdupe",
          noop      => "$readonly",
      }
    }

    else {
      group {
        "$group":
          ensure    => "$ensure",
          gid       => "$gid",
          allowdupe => "$allowdupe",
          noop      => "$readonly",
      }
    }
  }
}   
