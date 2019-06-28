define ucm::custom::base::services (
  $lookupitem,
  $os                    = $title,
  $manage_these_services = lookup({"name" => "$lookupitem", "default_value" => {"default"=>{"state"=>"stopped","noop"=>"false"}}, "merge" => "deep", "value_type" => Hash}) 
){
  create_resources('ucm::custom::tiers::base::services', $manage_these_services)
}
