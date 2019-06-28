class ucm::product::links (
  $lookupitem         = 'links',
  $manage_these_links = lookup({"name" => "$lookupitem", "default_value" => {"/tmp/${::product}_default_link"=>{"ensure"=>"absent"}}, "merge" => "deep"})
){
  create_resources('ucm::custom::links', $manage_these_links)
}
