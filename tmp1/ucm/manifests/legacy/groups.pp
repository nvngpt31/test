class ucm::legacy::groups (
  $groups = hiera('groups')
){
  create_resources('ucm::custom::groups', $groups)
}
