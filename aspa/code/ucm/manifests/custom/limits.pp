define ucm::custom::limits (
  $limit     = $title,
  $ensure    = 'present',
  $user      = 'nouser',
  $hard      = '0',
  $soft      = '0',
  $limdir    = '/etc/security/limits.d', 

){

  # VALUE 'null' FOR TITLE IS PROVIDED BY DEFAULT IN ucm/manifests/custom/*/limits.pp
  if $limit != 'null' {

    $lim_template = @("END")
      $user hard $limit $hard
      $user soft $limit $soft
    | END
  
    file {
      "${limdir}/${user}_${limit}.conf":
        ensure  => $ensure, 
        content => inline_template($lim_template)
    }

  }
}

