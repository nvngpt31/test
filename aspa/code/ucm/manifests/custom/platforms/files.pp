define ucm::custom::platforms::files (
  $platform = $title,
  $lookupitem,
  $manage_these_files = lookup({"name" => "$lookupitem", "default_value" => {"/tmp/platform_default_file"=>{"ensure"=>"absent"}}})
){
  create_resources('ucm::custom::files', $manage_these_files)
}
