define ucm::custom::tiers::product::directories (
  $execpath = '/usr/ucb:/usr/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin',
  $path     = $title, 
  $ensure   = 'directory',
  $defined  = 'false',
  $owner    = 'root', 
  $group    = 'root',
  $mode     = '0775',
  $recurse  = 'false',
  $readonly = true,

){

  if $path == 'default' {
    notify { 'msg_dir_def': message => "No Directories defined for base tier." }
  }
  else {
    file {
      "$path":
        ensure  => "$ensure", 
        owner   => "$owner",
        group   => "$group",
        mode    => "$mode",
        recurse => "$recurse",
        noop    => "$readonly",
    }
  }
}

