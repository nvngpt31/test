define ucm::custom::tiers::base::sysctl (
  $execpath        = hiera('execpath'),
  $path            = $title,
  $defined         = 'false',
  $owner           = 'root',
  $group           = 'root',
  $mode            = '644',
  $replace         = 'true',
  $ensure          = 'present',
  $recurse         = 'false',
  $template        = 'nodef',
  $readonly            = 'true',
  $modparams,

){

  if $path == '/tmp/.sysctl' or $path == undef {
    notify { 
      'msg_sys_def': 
        message => "No sysctl Files defined for base tier." 
    }
  }

  else {

    if $template == 'nodef' {
      notify { "You must provide an .epp template for this resource type.": }
    }

    else {

      notify {
        "concatsysctl":
          message => "Concatenating sysctl params for $path"
      }

      exec {
        "concat_${path}":
          command => "/usr/local/bin/concat_sysctl -f $path",
          require => Notify['concatsysctl'],
          noop    => 'false'
      }

      file {
        "$path":
          ensure  => $ensure,
          owner   => $owner,
          group   => $group,
          mode    => $mode,
          recurse => $recurse,
          replace => $replace,
          content => epp("$template", $modparams),
          require => Exec["concat_${path}"],
          noop    => $readonly,
      }
    }
  }
}
