
# added this comment for testing
# blah blah blah
class tda (
  $execpath          = '/usr/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin',
  $bash_profile_path = $tda::params::bash_profile_path,
  $isv_packages      = $tda::params::isv_packages,
  $anacronmailto     = '', # Must be blank
  $cronmailto        = ''  # Must be blank

)inherits tda::params {

  exec {
    "tda_remove_S99":
      path    => "$execpath",
      command => "rm -f /etc/rc.d/rc3.d/S99run_puppet",
      onlyif  => "test -f /etc/rc.d/rc3.d/S99run_puppet"
  }

  class { 
    'tda::tdafirst': 
      stage => 'first'
  }

  class { 
    'tda::isv': 
  } 
  
  class { 
    'tda::tdaconfigs': 
      require => Class['tda::isv']
  }
}
