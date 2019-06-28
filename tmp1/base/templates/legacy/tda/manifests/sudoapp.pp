# class for adding sudoers for apps - std-springboot & std-tc_server 
#
class tda::sudoapp { 

  if ($::app == 'std-springboot') or ($::app == 'std-tc_server') {
    file { 
      '/etc/sudoers.d/zdeploy':
        ensure  => 'present',
        content => template('tda/zdeploy_sudo.erb'), 
        mode    => '0640'
    }
  }
}
