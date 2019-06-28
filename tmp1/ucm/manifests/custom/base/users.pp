define ucm::custom::base::users (
  $lookupitem, 
  $os                 = $title,
  $manage_these_users = lookup({"name" => "$lookupitem", "default_value" => {"default"=>{"ensure"=>"absent"}}, "merge" => "deep", "value_type" => Hash}) 

){
  create_resources('ucm::custom::tiers::base::users', $manage_these_users)
}
