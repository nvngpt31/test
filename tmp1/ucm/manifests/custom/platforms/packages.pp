define ucm::custom::platforms::packages (
  $platform = $title,
  $lookupitem,
  $manage_these_packages = lookup({"name" => "$lookupitem", "default_value" => {"platform_ucm_default"=>{"ensure"=>"absent"}}})
){
  create_resources('package', $manage_these_packages)
}
