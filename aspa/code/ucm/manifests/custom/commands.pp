define ucm::custom::commands (
  $command = $title,
  $tagname = 'nodef',
  $defined = 'false',
  $path    = lookup('execpath'),
  $flag    = "${::facter_dir}/facts.d/flag_${tagname}.txt",
  $runas   = 'root',

){

  if $command == 'blank' {
  }

  else {
    exec {
      "exec_for_$tagname":
        path    => $path,
        user    => $runas,
        command => "$command",
        unless  => "test -f $flag"
    }
  
    file {
      "$flag":
        ensure  => 'present',
        require => Exec["exec_for_$tagname"]
    }
  }
}
