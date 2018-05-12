define ucm::custom::tools::cmds (
  $tool = $title,
  $lookupitem,
  $manage_these_cmds = lookup({"name" => "$lookupitem", "default_value" => {":"=>{"runas"=>"smeucmnull"}}})
){
  create_resources('ucm::custom::cmd', $manage_these_cmds)
}
