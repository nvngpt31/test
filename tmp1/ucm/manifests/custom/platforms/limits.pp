define ucm::custom::platforms::limits (
  $platform = $title,
  $lookupitem,
  $manage_these_limits = lookup({"name" => "$lookupitem", "default_value" => {"void"=>{"ensure"=>"void"}}})
){
  create_resources('ucm::custom::limits', $manage_these_limits)
}
