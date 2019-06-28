define ucm::custom::platforms::files (
  $platform = $title,
  $lookupitem,
  $manage_these_files = lookup({"name" => "$lookupitem", "value_type" => Hash, "default_value" => {"/tmp/platform_default_file"=>{"ensure"=>"absent"}}, "merge" => "deep"}),
  $modparams          = lookup({"name" => "modparams", "value_type" => Hash, "default_value" => {"modparams"=>{"modparam"=>"null"}}, "merge" => "deep"}),


){
  $defaults = {
    'modparams' => $modparams,
  } 

  create_resources('ucm::custom::files', $manage_these_files, $defaults)
}
