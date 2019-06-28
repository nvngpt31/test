define ucm::custom::tiers::tools::users (
  $tool = $title,
  $lookupitem,
  $manage_these_users = lookup({"name" => "$lookupitem", "default_value" => {"tool_user"=>{"ensure"=>"absent"}}, "merge" => "deep", "value_type" => Hash})
){
  create_resources('user', $manage_these_users)
}
