define ucm::custom::base::directories (
  $lookupitem,
  $os                       = $title,
  $manage_these_directories = lookup({"name" => "$lookupitem", "default_value" => {"default"=>{"ensure"=>"absent","noop"=>"false"}}, "merge" => "deep", "value_type" => Hash})

){
  create_resources('ucm::custom::tiers::base::directories', $manage_these_directories)
}
