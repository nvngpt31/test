define ucm::custom::touchtool (
  $path = '/bin:/usr/bin',
  $dir  = '/etc/facter/facts.d',
  $tool = $title, 
  $ensure,

){
  exec {
    "touch_${tool}":
      path    => "$path",
      command => "touch ${dir}/smeucmtool_${tool}.txt",
      unless  => "test -f ${dir}/smeucmtool_${tool}.txt",
  }
}


