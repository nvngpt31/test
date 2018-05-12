class ucm::base::groups (
  $groups    = lookup('base::groups'),

){
  create_resources('ucm::custom::groups', $groups)
}
