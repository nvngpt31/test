define ucm::custom::tiers::tools::services (
  $tool = $title,
  $lookupitem,
  $manage_these_services = lookup({"name" => "$lookupitem", "default_value" => {"ucmservice"=>{"state"=>"stopped"}}, "merge" => "deep", "value_type" => Hash})
){
  create_resources('ucm::custom::services', $manage_these_services)
}
