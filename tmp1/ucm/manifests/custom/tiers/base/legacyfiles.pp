define ucm::custom::tiers::base::legacyfiles (
  $execpath        = hiera('execpath'),
  $path            = $title,
  $owner           = 'root',
  $group           = 'root',
  $mode            = '0755',
  $replace         = 'true',
  $ensure          = 'present',
  $recurse         = 'false',
  $template        = 'nodef',
  $restart_service = 'false',
  $readonly        = 'true',

){

  if $path == 'blank' {}
  else {

    if $template == 'nodef' {
      file {
        "$path":
          ensure  => $ensure,
          owner   => $owner,
          group   => $group,
          mode    => $mode,
          noop    => $readonly,
          recurse => $recurse,
          replace => $replace,
      }
    }

    else {
      file {
        "$path":
          ensure  => $ensure,
          owner   => $owner,
          group   => $group,
          mode    => $mode,
          noop    => $readonly,
          recurse => $recurse,
          replace => $replace,
          content => template("$template"),
      }
    }

    if $restart_service != 'false' {
      exec {
        "${path}_${restart_service}": 
          path        => "$execpath",
          command     => "service $restart_service restart",
          noop        => $readonly,
          refreshonly => 'true',
          subscribe   => "$path"
      }
    }
  }
}
