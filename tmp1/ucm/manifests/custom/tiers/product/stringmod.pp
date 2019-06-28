define ucm::custom::tiers::product::stringmod (
  $script   = '/usr/local/bin/ucm-stringmod.py',
  $tagname  = "$title",
  $execpath = 'nullval',
  $path     = 'nullval',
  $method   = 'nullval',
  $replace  = 'string',
  $update   = 'first',
  $search   = 'nullval',
  $shouldbe = 'nullval',
  $readonly = true,
  $unless   = '/bin/false',
  $backup   = false,

)
{

  $command = $method ? {
    default   => "$script -m ${method} -r \"${replace}\" -u \"${update}\" -f \"${path}\" -s \"${search}\" -sh \"${shouldbe}\"",
  }

  if $backup == true {
    exec {
      "backup_for_${tagname}":
        path     => "$execpath",
        command  => "cp -p ${path} ${path}.ucm-${tagname}.`date +%F_%I_%M_%S_%p`", 
        noop     => "$readonly", 
        before   => Exec["strmod_for_${tagname}"],
    }
  }

  exec {
    "strmod_for_${tagname}":
      path    => "$execpath",
      command => "$command",
      unless  => "$unless",
      noop    => "$readonly",
  }

}
