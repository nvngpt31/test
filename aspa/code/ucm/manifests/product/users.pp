class ucm::product::users (
  $lookupitem = 'users',
  $manage_these_users = lookup({"name" => "$lookupitem", "default_value" => {"${::product}_user"=>{"ensure"=>"absent"}}})
){
  create_resources('ucm::custom::users', $manage_these_users)
}
