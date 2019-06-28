define ucm::custom::touchapp (
  $path = '/bin:/usr/bin',
  $dir  = '/etc/facter/facts.d',
  $app  = $title, 
  $ensure,
  $platform,

){

  exec {
    "touch_${app}":
      path    => "$path",
      command => "touch ${dir}/smeucmapp_${app}_smeucmplatform_${platform}.txt",
      unless  => "test -f ${dir}/smeucmapp_${app}_smeucmplatform_${platform}.txt",
  }
}


