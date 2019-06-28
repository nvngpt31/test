class ucm::legacy::users (
  $users = hiera('users')
){
  create_resources('ucm::custom::legacy::users', $users)
}
