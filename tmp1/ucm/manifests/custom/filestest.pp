define ucm::custom::files (
  $path     = $title,
  $defined  = 'false',
  $owner    = 'root',
  $group    = 'root',
  $mode     = '0755',
  $replace  = 'true',
  $ensure   = 'present',
  $recurse  = 'false',
  $template = 'nodef',
  $readonly = true,

){

  if $path == 'blank' {
    #    notify {
    #  'msg_fle_blank':
    #    message => '...NO FILES TO BE MANAGED AT THIS TIME'
    #}
  }

  else {

    if $template == 'nodef' {
      file {
        "$path":
          ensure  => $ensure,
          owner   => $owner,
          group   => $group,
          mode    => $mode,
          recurse => $recurse,
          replace => $replace,
          noop    => "$noop",
      }
    }

    else {
      file {
        "$path":
          ensure  => $ensure,
          owner   => $owner,
          group   => $group,
          mode    => $mode,
          recurse => $recurse,
          replace => $replace,
          content => epp("$template"),
          noop    => "$noop",
      }
    }
  }
}
