define ucm::custom::tiers::tools::cmds (
  $tool = $title,
  $lookupitem,
  $manage_these_cmds = lookup({"name" => "$lookupitem", "default_value" => {":"=>{"runas"=>"smeucmnull"}}, "merge" => "deep", "value_type" => Hash})
){
  create_resources('ucm::custom::execs', $manage_these_cmds)
}
