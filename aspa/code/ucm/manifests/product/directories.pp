class ucm::product::directories (
  $lookupitem               = 'directories',
  $manage_these_directories = lookup({"name" => "$lookupitem", "default_value" => {"/tmp/${::product}_default_dir"=>{"ensure"=>"absent"}}})
){
  #create_resources('file', $manage_these_directories)
  create_resources('ucm::custom::directories', $manage_these_directories)
}
