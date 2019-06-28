define ucm::custom::platforms::links (
  $platform = $title,
  $lookupitem,
  $manage_these_links = lookup({"name" => "$lookupitem", "default_value" => {"/tmp/platform_default_link"=>{"ensure"=>"absent"}}})
){
  create_resources('ucm::custom::links', $manage_these_links)
}
