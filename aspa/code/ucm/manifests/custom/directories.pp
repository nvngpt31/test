define ucm::custom::directories (
  $execpath = '/usr/ucb:/usr/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin',
  $path     = $title, 
  $ensure   = 'directory',
  $defined  = 'false',
  $owner    = 'root', 
  $group    = 'root',
  $mode     = '0775',

){

  # NOTE: I THINK THERE'S A BUG IN THIS VERSION OF PUPPET, BUT WHEN WE WERE SETTING THE OWNER
  # OF THE DIR, IT WAS ERRORING OUT IN ATTEMPTING TO VERIFY THE DIFFERENCE BETWEEN "IS" AND "SHOULD".
  # I TESTED WITH SETTING JUST THE UID OF THE USER AS SEEN BELOW WITH SUCCESS.

  # ALSO WTF IS WRONG WITH MODE?

  #$useruid = generate ("/bin/bash", "-c", "/usr/bin/id -u $owner")

  # Path being blank is set in hiera when we look this up in the class
  # that's calling this defined type
  if $path == 'blank' {
  }

  else {
    file {
      "$path":
        ensure => 'directory',
        owner  => "$owner",
        group  => "$group",
        mode   => "$mode",
    }

    #exec {
    #  "chmod_${path}":
    #    path    => $execpath,
    #    command => "chmod ${mode} ${path}",
    #    require => File["$path"]
    #}
  }
}

