define ucm::custom::tiers::product::files (
  $path      = $title,
  $defined   = 'false',
  $owner     = 'root',
  $group     = 'root',
  $mode      = '0755',
  $replace   = 'true',
  $ensure    = 'present',
  $template  = 'nodef',
  $readonly  = true,
  $modparams,

){

  if $template == 'nodef' {
    file {
      "$path":
        ensure  => $ensure,
        owner   => $owner,
        group   => $group,
        mode    => $mode,
        replace => $replace,
        noop    => "$readonly",
    }
  }

  else {
    if '.epp' in $template {
      file {
        "$path":
          ensure  => $ensure,
          owner   => $owner,
          group   => $group,
          mode    => $mode,
          replace => $replace,
          content => epp("$template", $modparams),
          noop    => "$readonly",
      }
    }

    elsif '.erb' in $template {
      file {
        "$path":
          ensure  => $ensure,
          owner   => $owner,
          group   => $group,
          mode    => $mode,
          replace => $replace,
          content => template("$template"),
          noop    => $readonly,
      }
    }
  }
}


