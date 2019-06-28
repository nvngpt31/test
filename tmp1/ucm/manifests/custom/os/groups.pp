define ucm::custom::os::groups (
  $os = $title,
  $lookupitem,
  $manage_these_groups = hiera($lookupitem)
){
  create_resources('ucm::custom::groups', $manage_these_groups)
}
