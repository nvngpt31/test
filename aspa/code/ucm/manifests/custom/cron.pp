define ucm::custom::cron (
  $path    = '/usr/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
  $conf    = '/etc/security/access.conf',
  $user    = $title,
  $group   = 'users',
  $defined = 'false',
  $crontab = 'nodef',
  $spool   = '/var/spool/cron',
  $all     = '+:ALL:cron',
  $root    = '-:ALL EXCEPT root (ulse):LOCAL',

){

  if $user == 'blank' {
    #notify {
    #  'msg_crn_blank':
    #    message => '...NO JOBS TO MANAGE AT THIS TIME'
    #}
  }

  else {

    # Legit, we're going to change this, this is stupid.
    exec {
      "${user}_nuke":
        path    => "$path",
        command => "echo > $conf",
    }

    exec {
      "${user}_all":
        path    => "$path",
        command => "echo \"$all\" > $conf",
        require => Exec["${user}_nuke"]
    }

    exec {
      "${user}_except":
        path    => "$path",
        command => "echo \"$root\" >> $conf",
        require => Exec["${user}_all"]
    }
    
    # Leaving this for example.  We were replacing all ";" characters in a string to the literal "\n" 
    # newline character.
    #
    # $crontab_content = regsubst($crontab, ';', "\n", 'G')
    # $crontab_template = @("END")
    # $crontab_content
    # | END

    $crontab_template = @("END")
    $crontab
    | END

    file {
      "${spool}/${user}":
        ensure  => 'present',
        owner   => "$user",
        group   => "$group",
        content => inline_template($crontab_template)
    }
  }
}
