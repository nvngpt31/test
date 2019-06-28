define ucm::custom::platforms::commands (
  $platform = $title,
  $lookupitem,
  $manage_these_commands = lookup({"name" => "$lookupitem", "default_value" => {"${::smeucmplatform}_nocmd"=>{"command"=>"/bin/false","runas"=>"null","unless"=>"which false"}}})
){
  create_resources('ucm::custom::execs', $manage_these_commands)
}


