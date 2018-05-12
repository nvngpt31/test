define ucm::custom::platforms::limits (
  $platform = $title,
  $lookupitem,
  $manage_these_limits = lookup({"name" => "$lookupitem", "default_value" => {"platform_limit"=>{"limit"=>"null"}}})
){
  create_resources('ucm::custom::limits', $manage_these_limits)
}
