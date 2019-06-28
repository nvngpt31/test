define ucm::custom::base::sysctl (
  $lookupitem,
  $os                 = $title,
  $manage_these_files = lookup({"name" => "$lookupitem", "value_type" => Hash, "default_value" => {"/tmp/.sysctl"=>{"ensure"=>"absent"}}, "merge" => "deep"}),
  $modparams          = lookup({"name" => "modparams", "value_type" => Hash, "default_value" => {"modparams"=>{"modparam"=>"null"}}, "merge" => "deep"}),

){

  $defaults = {
    'modparams' => $modparams,
  }   

  create_resources('ucm::custom::tiers::base::sysctl', $manage_these_files, $defaults)

}
