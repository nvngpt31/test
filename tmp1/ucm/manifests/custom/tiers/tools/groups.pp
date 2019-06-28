define ucm::custom::tiers::tools::groups (
  $tool = $title,
  $lookupitem,
  $manage_these_groups = lookup({"name" => "$lookupitem", "default_value" => {"tool_ucm_default"=>{"ensure"=>"absent"}}, "merge" => "deep", "value_type" => Hash})
){
  create_resources('group', $manage_these_groups)
}
