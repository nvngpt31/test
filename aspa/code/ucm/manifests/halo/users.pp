class ucm::halo::users (
  $users = lookup('users'),

){
  create_resources('ucm::custom::users', $users)
}
