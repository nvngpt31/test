define ucm::custom::platforms::groups (
  $platform = $title,
  $lookupitem,
  $manage_these_groups = lookup({"name" => "$lookupitem", "default_value" => {"platform_ucm_default"=>{"ensure"=>"absent"}}})
){
  create_resources('group', $manage_these_groups)
}
