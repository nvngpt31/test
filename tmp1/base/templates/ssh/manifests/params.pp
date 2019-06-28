class ssh::params {

# Service options
  $service_ensure = 'running'
  $service_name = 'sshd'
  $service_enable = true
  $service_hasrestart = true
  $service_hasstatus = true

# sshdconfig options
  $protocol = '2'
  $x11forwarding = 'yes'
  $ignorerhosts = 'yes'
  $hostbasedauthentication = 'no'
  $permitrootlogin = 'without-password'
  $permitemptypasswords = 'no'
  $banner = '/etc/issue'
  $printmotd = 'yes'

}
