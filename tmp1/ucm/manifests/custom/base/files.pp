define ucm::custom::base::files (
  $lookupitem,
  $os                 = $title,

  $manage_these_files = lookup({"name" => "$lookupitem", "value_type" => Hash, "default_value" => {"/tmp/.basefile"=>{"ensure"=>"absent"}}, "merge" => "deep"}), 
  $modparams          = lookup({"name" => "modparams", "value_type" => Hash, "default_value" => {"modparams"=>{"modparam"=>"null"}}, "merge" => "deep"}),

){

  $defaults = {
    'modparams' => $modparams,
  }   

  create_resources('ucm::custom::tiers::base::files', $manage_these_files, $defaults)
}
