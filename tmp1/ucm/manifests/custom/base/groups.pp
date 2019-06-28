define ucm::custom::base::groups (
  $lookupitem, 
  $os                  = $title,
  $manage_these_groups = lookup({"name" => "$lookupitem", "default_value" => {"default"=>{"ensure"=>"absent"}}, "merge" => "deep", "value_type" => Hash}) 
){
  create_resources('ucm::custom::tiers::base::groups', $manage_these_groups)
}
