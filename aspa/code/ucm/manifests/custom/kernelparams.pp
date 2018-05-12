define ucm::custom::kernelparams (
  $path        = '/usr/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
  $kernelparam = $title,
  $defined     = 'false',
  $value       = '0',
  $sysdir      = '/etc/sysctl.d', 
  $comment     = 'Default',

){

  $sys_template = @("END")
  # $comment
  $kernelparam=$value
  | END

  if $kernelparam == 'blank' {
    #    notify {
    #  'msg_ker_blank':
    #    message => '...NO KERNEL PARAMS TO MANAGE AT THIS TIME'
    #}
  }

  else { 
    file {
      "${sysdir}/${kernelparam}.conf":
        ensure  => 'present',
        content => inline_template($sys_template)
    }

    exec {
      "reloading_${kernelparam}":
        path    => "$path",
        command => "sysctl -p /etc/sysctl.d/* >/dev/null 2>&1",
        require => File["${sysdir}/${kernelparam}.conf"]
    }
  }
}

