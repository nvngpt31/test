define ucm::custom::base::packages (
  $lookupitem,
  $os                    = $title,
  $manage_these_packages = lookup({"name" => "$lookupitem", "default_value" => {"default"=>{"state"=>"absent"}}, "merge" => "deep", "value_type" => Hash}) 

){
  create_resources('ucm::custom::tiers::base::packages', $manage_these_packages)
}
