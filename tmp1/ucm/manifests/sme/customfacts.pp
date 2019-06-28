define ucm::sme::customfacts (
  $lookupitem,
  $manage_these_facts = lookup({"name" => "$lookupitem", "default_value" => {"thomas"=>{"value"=>"anderson"}}})
){
  create_resources('ucm::custom::createfact', $manage_these_facts)
}
