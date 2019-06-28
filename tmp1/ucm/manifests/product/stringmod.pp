class ucm::product::stringmod (
  $lookupitem              = 'stringmod',
  $manage_these_stringmods = lookup({"name" => "$lookupitem", "default_value" => {"nullval"=>{"path"=>"nullval"}}, "merge" => "deep"})

){
  
  # ensures package python and udpates stringmod script
  contain ucm::custom::stringmodreq
  create_resources('ucm::custom::stringmod', $manage_these_stringmods)

}
