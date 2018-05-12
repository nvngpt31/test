class ucm::product::groups (
  $lookupitem          = 'groups',
  $manage_these_groups = lookup({"name" => "$lookupitem", "default_value" => {"${::product}_ucm_default"=>{"ensure"=>"absent"}}})
){
  create_resources('ucm::custom::groups', $manage_these_groups)
}
