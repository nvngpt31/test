define ucm::custom::links (
  $path    = $title,
  $defined = 'false',
  $ensure  = 'link',
  $target  = 'blank',
  $owner   = 'root',
  $group   = 'root',
  $mode    = '0775',
  $readonly = true,

){

  if $path == 'blank' {
    notify {
      'msg_lnk_blank':
        message => '...NO LINKS TO BE MANAGED AT THIS TIME'
    }
  }

  else {
    file {
      "$path":
        ensure => $ensure,
        target => $target,
        owner  => $owner,
        group  => $group,
        mode   => $mode,
        noop   => $readonly,
    }
  }
}
