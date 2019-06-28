define ucm::custom::legacy::limits (
  $execpath   = hiera('execpath'),
  $label      = $title,
  $ensure     = 'present',
  $limit_type = "nofile",
  $user       = 'nouser',
  $hard       = '0',
  $soft       = '0',
  $limdir     = '/etc/security/limits.d', 
  $readonly   = true,

){

  $ro = $::gro ? {
    'on'    => true,
    'off'   => false,
    default => $readonly
  }
  

  if $label == 'null' or $label == 'blank' {
  }
  
  else {
    exec {
      "limits_for_${label}_hard":
        path    => "$execpath",
        command => "echo \"$user hard $limit_type $hard\" > ${limdir}/${user}_${limit_type}.conf", 
        noop    => $ro,
    }

    exec {
      "limits_for_${label}_soft":
        path    => "$execpath",
        command => "echo \"$user soft $limit_type $soft\" >> ${limdir}/${user}_${limit_type}.conf",
        noop    => $ro,
        require => Exec["limits_for_${label}_hard"]
    }
  }
}

