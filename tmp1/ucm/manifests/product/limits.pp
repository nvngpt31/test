class ucm::product::limits (
  $lookupitem          = 'limits',
  $manage_these_limits = lookup({"name" => "$lookupitem", "default_value" => {'blank'=>{"limit_type"=>"nofile"}}, "merge" => "deep"})
){
  create_resources('ucm::custom::limits', $manage_these_limits)
}
