class ucm::product::centrifyzone (
  $lookupitem     = 'centrifyzone',
  $manage_centrifyzone = lookup({"name" => "$lookupitem", "default_value" => {"${::product}_centrifyzone"=>{"ensure"=>"nullval"}}, "merge" => "deep"})
){
  contain ucm::custom::centrifyzonereq
  create_resources('ucm::custom::centrifyzone', $manage_centrifyzone)
}
