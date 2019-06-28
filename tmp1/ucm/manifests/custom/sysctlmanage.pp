define ucm::custom::sysctlmanage (
  $script   = "/usr/local/bin/ucm-manage-sysctl",
  $execpath = hiera('execpath'),
  $path     = 'nullval',
  $param    = $title,
  $value    = 'nullval',
  $readonly = true, 

)
{

  contain ucm::crossversion::utilities
  $command = "$script -f $path -p \"$param\" -v \"$value\""

  exec {
    "sysctlmanage_${tagname}":
      path    => "$execpath",
      command => "$command",
      noop    => "$readonly",
  }

}
