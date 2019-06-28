define ucm::custom::tiers::tools::directories (
  $tool = $title,
  $lookupitem,
  $manage_these_directories = lookup({"name" => "$lookupitem", "default_value" => {"/tmp/tool_default_dir"=>{"ensure"=>"absent"}}, "merge" => "deep", "value_type" => Hash})
){
  create_resources('file', $manage_these_directories)
}
