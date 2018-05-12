define ucm::custom::tools::packages (
  $tool = $title,
  $lookupitem,
  $manage_these_packages = lookup({"name" => "$lookupitem", "default_value" => {"tool_ucm_default"=>{"ensure"=>"absent"}}})
){
  create_resources('package', $manage_these_packages)
}
