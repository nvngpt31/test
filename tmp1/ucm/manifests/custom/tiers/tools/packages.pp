define ucm::custom::tiers::tools::packages (
  $tool = $title,
  $lookupitem,
  $manage_these_packages = lookup({"name" => "$lookupitem", "default_value" => {"tool_ucm_default"=>{"ensure"=>"absent"}}, "merge" => "deep", "value_type" => Hash})
){
  create_resources('package', $manage_these_packages)
}
