# == Class: ssh
#
# Full description of class ssh here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ssh servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ssh_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#  sshd_config { "AllowGroups":
#  ensure  => present,
#    value => ["sshgroups", "admins"],
#}
#
# === Authors
#
# Author Name <laurent.dom@tdameritrade.com>
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#
class ssh (
  $service_ensure = $ssh::params::service_ensure,
  $service_name = $ssh::params::service_name,
  $service_enable = $ssh::params::service_enable,
  $service_hasrestart = $ssh::params::service_hasrestart,
  $service_hasstatus = $ssh::params::service_hasstatus,
  $protocol = $ssh::params::protocol,
  $x11forwarding = $ssh::params::x11forwarding,
  $ignorerhosts = $ssh::params::ignorerhosts,
  $hostbasedauthentication = $ssh::params::hostbasedauthentication,
  $permitrootlogin = $ssh::params::permitrootlogin,
  $permitemptypasswords = $ssh::params::permitemptypasswords,
  $banner = $ssh::params::banner,
  $printmotd = $ssh::params::printmotd
)inherits ssh::params {
  class {'ssh::config': } ->
  class {'ssh::service': } ->
  Class['ssh']
}
