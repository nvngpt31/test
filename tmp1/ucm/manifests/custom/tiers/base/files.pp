define ucm::custom::tiers::base::files (
  $execpath        = hiera('execpath'),
  $path            = $title,
  $defined         = 'false',
  $owner           = 'root',
  $group           = 'root',
  $mode            = '0755',
  $replace         = 'true',
  $ensure          = 'present',
  $recurse         = 'false',
  $template        = 'nodef',
  $readonly            = 'true',
  $modparams,

){

  if $path == '/tmp/.basefile' or $path == 'blank' {
    notify { 'msg_fil_def': message => "No Files defined for base tier." }
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
          noop    => $readonly,
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
            recurse => $recurse,
            replace => $replace,
            content => epp("$template", $modparams),
            noop    => $readonly,
        }
      }

      elsif '.erb' in $template {
        file {
          "$path":
            ensure  => $ensure,
            owner   => $owner,
            group   => $group,
            mode    => $mode,
            recurse => $recurse,
            replace => $replace,
            content => template("$template"),
            noop    => $readonly,
        }
      }
    }
  }
}
