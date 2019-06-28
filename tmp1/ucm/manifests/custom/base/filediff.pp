define ucm::custom::base::filediff (
  $lookupitem,
  $os                     = $title,
  $manage_these_filediffs = lookup({"name" => "$lookupitem", "value_type" => Hash, "default_value" => {"/tmp/.basefilediff"=>{"ensure"=>"absent"}}, "merge" => "deep"}), 
  $modparams              = lookup({"name" => "modparams", "value_type" => Hash, "default_value" => {"modparams"=>{"modparam"=>"null"}}, "merge" => "deep"}),

){

  $defaults = {
    'modparams' => $modparams,
  }   

  create_resources('ucm::custom::tiers::base::filediffs', $manage_these_filediffs, $defaults)
}
