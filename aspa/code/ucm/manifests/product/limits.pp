class ucm::product::limits (
  $lookupitem          = 'limits',
  $manage_these_limits = lookup({"name" => "$lookupitem", "default_value" => {"${platform}_limit" => {"limit" =>"null"}}})
){
  create_resources('ucm::custom::limits', $manage_these_limits)
}
