class ucm::standalone::users (
  $users = hiera('base::users'),

){
  create_resources('ucm::custom::users', $users)
}
