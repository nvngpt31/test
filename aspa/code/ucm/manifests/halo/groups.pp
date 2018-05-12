class ucm::halo::groups (
  $groups    = lookup('groups'),

){
  create_resources('ucm::custom::groups', $groups)
}
