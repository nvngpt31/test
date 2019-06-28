define ucm::custom::tiers::base::backend_cron (
  $execpath   = '/usr/ucb:/usr/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin',
  $script     = '/usr/local/bin/ucm-salt-applybase.sh',
  $outputdest = '/dev/null',
  $cronfor    = $title,
  $state      = 'applybase',
  $fact       = 'null',
  $value      = 'null',
  $frequency  = 'null',
  $user       = 'root',
  $minute     = "*",
  $hour       = "*",
  $weekday    = "*",
  $monthday   = "*",
  $month      = "*",

){

  if $cronfor == 'null' {
  } 

  else {
    cron {
      "Cron for $cronfor":
        command     => "${script} -f $fact -v $value -s $state > ${outputdest}",
        environment => "PATH=${execpath}",
        user        => "$user",
        minute      => "$minute",
        hour        => "$hour",
        weekday     => "$weekday",
        monthday    => "$monthday",
        month       => "$month",
    }
  }

}
