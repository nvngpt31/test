class ucm::product::files (
  $lookupitem         = 'files',
  $manage_these_files = lookup({"name" => "$lookupitem", "default_value" => {"/tmp/${::product}_default_file"=>{"ensure"=>"absent"}}})
){
  create_resources('ucm::custom::files', $manage_these_files)
}
