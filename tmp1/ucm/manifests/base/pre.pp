class ucm::base::pre (
  $path      = '/bin:/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin',
  $factsfile = '/etc/facter/facts.d/tdaenv.txt', 
  $envfile   = '/etc/tda/env',
  $dirbin    = '/usr/local/bin',

){

  contain ucm::crossversion::cleanup


  file {
    "${dirbin}/setfact":
      ensure  => 'present',
      mode    => '755',
      content => epp('ucm/bin/setfact.epp') 
  }

  file {
    "${dirbin}/concat_sysctl":
      ensure  => 'present',
      mode    => '755',
      content => epp('ucm/bin/concat_sysctl.epp') 
  }

  # Added this 2/8/2019 to recreate tdaenv facts file.  Earlier versions of the installer
  # removed this and didn't replace it.  Some servers were upgraded with that previous installer.
  exec {
    "remake_tdaenv": 
      path    => "$path",
      command => "cat $envfile | grep -vi hostname | tr '[:upper:]' '[:lower:]' > $factsfile",
      unless  => "test -f $factsfile",
  }
}
