class ucm::product::commands (
  $lookupitem            = 'commands',
  $manage_these_commands = lookup({"name" => "$lookupitem", "default_value" => {"${::product}_nocmd"=>{"command"=>"/bin/false","runas"=>"null","unless"=>"which false"}}, "merge" => "deep"})
  # $manage_these_commands = lookup({"name" => "$lookupitem", "default_value" => {"blank"=>{"command"=>"/bin/false"}}})

){
  create_resources('ucm::custom::execs', $manage_these_commands)
}

