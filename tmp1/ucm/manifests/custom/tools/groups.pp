define ucm::custom::tools::groups (
  $tool = $title,
  $lookupitem,
  $manage_these_groups = lookup({"name" => "$lookupitem", "default_value" => {"tool_ucm_default"=>{"ensure"=>"absent"}}})
  # $manage_these_groups = lookup({"name" => "$lookupitem", "default_value" => {"tool_ucm_default"=>{"ensure"=>"absent"}}})
){
  create_resources('group', $manage_these_groups)
}
