define ucm::custom::tools::directories (
  $tool = $title,
  $lookupitem,
  $manage_these_directories = lookup({"name" => "$lookupitem", "default_value" => {"/tmp/tool_default_dir"=>{"ensure"=>"absent"}}})
){
  create_resources('file', $manage_these_directories)
}
