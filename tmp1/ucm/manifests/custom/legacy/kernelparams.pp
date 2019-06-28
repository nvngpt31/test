define ucm::custom::legacy::kernelparams (
  $execpath    = hiera('execpath'), 
  $kernelparam = $title,
  $defined     = 'false',
  $value       = '0',
  $sysdir      = '/etc/sysctl.d', 
  $comment     = 'Default',

){

  if $kernelparam == 'blank' {
    #    notify {
    #  'msg_ker_blank':
    #    message => '...NO KERNEL PARAMS TO MANAGE AT THIS TIME'
    #}
  }

  else { 
    exec {
      "sysctl_dir_${kernelparam}":
        path    => "$execpath",
        command => "mkdir -p $sysdir",
        unless  => "test -d $sysdir",
        before  => Exec["sysctl_${kernelparam}"],
        returns => ["0", "255"]
    }

    exec {
      "sysctl_${kernelparam}":
        path    => "$execpath",
        command => "echo \"$kernelparam = $value\" > ${sysdir}/${kernelparam}.conf",
        returns => ["0", "255"]
    }

    exec {
      "reloading_${kernelparam}":
        path    => "$path",
        command => "sysctl -p /etc/sysctl.d/* >/dev/null 2>&1",
        require => Exec["sysctl_${kernelparam}"],
        returns => ["0", "255"]
    }
  }
}

