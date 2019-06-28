define ucm::custom::legacy::commands (
  $execpath        = hiera('execpath'),
  $tagname         = $title,
  $command         = 'true',
  $runas           = 'root',
  $unless          = 'false', 
  $logoutput       = 'true',
  $timeout         = '14400',
  $require_tagname = 'null',

){
  if $require_tagname == 'null' {
    exec {
      "$tagname":
        path      => "$execpath",
        command   => "$command",
        unless    => "$unless",
        timeout   => "$timeout",
        logoutput => true,
        returns   => [
          '0',
          '1',
        ]
    }
  }

  else {
    exec {
      "$tagname":
        path      => "$execpath",
        command   => "$command",
        unless    => "$unless",
        timeout   => "$timeout",
        logoutput => true,
        require   => Exec["$require_tagname"],
        returns   => [
          '0',
          '1',
        ]
    }
  }
}
