define ucm::custom::tools::files (
  $tool = $title,
  $lookupitem,
  $manage_these_files = lookup({"name" => "$lookupitem", "default_value" => {"/tmp/tool_default_file"=>{"ensure"=>"absent"}}})
){
  create_resources('ucm::custom::files', $manage_these_files)
}
