define ucm::custom::kernelparams (
  $execpath    = lookup('execpath'), 
  $kernelparam = $title,
  $defined     = 'false',
  $value       = '0',
  $sysdir      = '/etc/sysctl.d', 
  $comment     = 'Default',
  $readonly    = true,

){

  if $kernelparam == 'blank' {
  }

  else { 
    exec {
      "sysctl_dir_${kernelparam}":
        path    => "$execpath",
        command => "mkdir -p $sysdir",
        noop    => $readonly,
        unless  => "test -d $sysdir",
        before  => Exec["sysctl_${kernelparam}"],
        returns => ["0", "255"]
    }

    exec {
      "sysctl_${kernelparam}":
        path    => "$execpath",
        command => "echo \"$kernelparam = $value\" > ${sysdir}/${kernelparam}.conf",
        noop    => $readonly,
        returns => ["0", "255"]
    }

    exec {
      "reloading_${kernelparam}":
        path    => "$path",
        command => "sysctl -p /etc/sysctl.d/* >/dev/null 2>&1",
        noop    => $readonly,
        require => Exec["sysctl_${kernelparam}"],
        returns => ["0", "255"]
    }
  }
}

