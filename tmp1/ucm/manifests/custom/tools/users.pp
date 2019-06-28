define ucm::custom::tools::users (
  $tool = $title,
  $lookupitem,
  $manage_these_users = lookup({"name" => "$lookupitem", "default_value" => {"tool_user"=>{"ensure"=>"absent"}}})
){
  create_resources('user', $manage_these_users)
}
