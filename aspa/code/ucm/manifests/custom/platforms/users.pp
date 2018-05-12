define ucm::custom::platforms::users (
  $platform = $title,
  $lookupitem,
  $manage_these_users = lookup({"name" => "$lookupitem", "default_value" => {"platform_user"=>{"ensure"=>"absent"}}})
){
  create_resources('ucm::custom::users', $manage_these_users)
}
