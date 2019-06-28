class ucm::product::kernelparams (
  $lookupitem                = 'kernelparams',
  $manage_these_kernelparams = lookup({"name" => "$lookupitem", "default_value" => {"blank"=>{"value"=>"nodef"}}, "merge" => "deep"})
){
  create_resources('ucm::custom::kernelparams', $manage_these_kernelparams)
}

