define local::gitsync (

  $mod         = $title,  
  $branch      = 'null', 
  $url         = 'null',
  $databranch  = 'null',
  $environment = "$::deployenv",

){

  exec {
    "cmd_${mod}":
      command => "/usr/local/bin/ucm-git $mod $branch $url $databranch $environment > /tmp/puppet-git-deploy-for-${mod}.txt"
  }

}
