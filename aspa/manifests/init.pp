
# added this comment for testing
# blah blah blah
class aspa (
  $execpath          = '/usr/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin',
  $bash_profile_path = $aspa::params::bash_profile_path,
  $isv_packages      = $aspa::params::isv_packages,
  $anacronmailto     = '', # Must be blank
  $cronmailto        = ''  # Must be blank

)inherits aspa::params {

  class {
    'aspa::aspafirst':
      stage => 'first'
  }

  class {
    'aspa::isv':
  }
  
  class {
    'aspa::aspaconfigs':
      require => Class['aspa::isv']
  }
}
