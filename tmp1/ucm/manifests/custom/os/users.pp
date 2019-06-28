define ucm::custom::os::users (
  $os = $title,
  $lookupitem,
  $manage_these_users = hiera($lookupitem)
){
  create_resources('ucm::custom::legacy::users', $manage_these_users)
}
