define ucm::custom::platforms::directories (
  $platform = $title,
  $lookupitem,
  $manage_these_directories = lookup({"name" => "$lookupitem", "default_value" => {"/tmp/platform_default_dir"=>{"ensure"=>"absent"}}})
){
  create_resources('file', $manage_these_directories)
}
