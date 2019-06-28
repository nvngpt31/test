class ucm::product::services (
  $lookupitem = 'services',
  $manage_these_services = lookup({"name" => "$lookupitem", "default_value" => {"default"=>{"ensure"=>"stopped"}}, "merge" => "deep"})
){
  create_resources('ucm::custom::services', $manage_these_services)
}
