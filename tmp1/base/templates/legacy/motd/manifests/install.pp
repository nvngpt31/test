
class motd::install {

  if $::env == 'prd' {

    # Production servers are site based
    file { '/etc/motd':
      ensure  => present,
      content => template("motd/${::building}_motd.erb"),
      owner   => root,
      group   => root,
      mode    => '0644',
    }

  } else {
    # Non-Production servers are env based
      file { '/etc/motd':
        ensure  => present,
        content => template("motd/${::env}_motd.erb"),
        owner   => root,
        group   => root,
        mode    => '0644',
      }
  }

  # All RHEL servers have /etc/profile.d directory
  file { '/etc/profile.d/motd_tda.sh':
    ensure  => present,
    source  => 'puppet:///modules/motd/motd_tda.sh',
    owner   => root,
    group   => root,
    mode    => '0555',
  }

}


