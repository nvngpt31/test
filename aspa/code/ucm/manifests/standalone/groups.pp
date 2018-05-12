class ucm::standalone::groups (
  $groups    = hiera('base::groups'),

){
  create_resources('ucm::custom::groups', $groups)
}
