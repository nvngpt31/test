define ucm::custom::limits (
  $execpath   = lookup('execpath'),
  $label      = $title,
  $ensure     = 'present',
  $limit_type = "nofile",
  $user       = 'nouser',
  $hard       = '0',
  $soft       = '0',
  $limdir     = '/etc/security/limits.d', 
  $readonly   = true,

){

  if $label == 'void' or $label == 'blank' {
  } 
 
  else {

    # VALUE 'null' FOR TITLE IS PROVIDED BY DEFAULT IN ucm/manifests/custom/*/limits.pp
    if $label != 'null' or $label != 'blank' {
      exec {
        "limits_for_${label}_hard":
          path    => "$execpath",
          noop    => $readonly,
          command => "echo \"$user hard $limit_type $hard\" > ${limdir}/${user}_${limit_type}.conf", 
      }

      exec {
        "limits_for_${label}_soft":
          path    => "$execpath",
          command => "echo \"$user soft $limit_type $soft\" >> ${limdir}/${user}_${limit_type}.conf",
          noop    => $readonly,
          require => Exec["limits_for_${label}_hard"]
      }
    }
  }
}

