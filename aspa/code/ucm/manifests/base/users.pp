class ucm::base::users (
  $users = lookup('base::users'),

){
  create_resources('ucm::custom::users', $users)
}
