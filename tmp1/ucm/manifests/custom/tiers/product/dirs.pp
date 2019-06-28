define ucm::custom::tiers::product::dirs (
  $path     = $title, 
  $ensure   = 'directory',
  $defined  = 'false',
  $owner    = 'root', 
  $group    = 'root',
  $mode     = '0775',
  $readonly = true,
  $recurse  = false,

){

  if $ensure == 'absent' {
    file {
      "$path":
        ensure  => "$ensure", 
        # ensure  => "$state", 
        noop    => $readonly,
        recurse => $recurse,
        force   => 'true'
    }
  }

  else {
    file {
      "$path":
        ensure  => "$ensure", 
        # ensure  => "$state", 
        owner   => "$owner",
        group   => "$group",
        mode    => "$mode",
        recurse => $recurse,
        noop    => $readonly,
    }

    #ucm::custom::fix::chmod {
    #  "$path":
    #    mode     => "$mode",
    #    execpath => "$execpath",
    #    require  => File["$path"],
    #}

  }
}

