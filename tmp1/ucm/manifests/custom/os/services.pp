define ucm::custom::os::services (
  $os = $title,
  $lookupitem,
  $manage_these_services = hiera($lookupitem)
){
  create_resources('ucm::custom::services', $manage_these_services)
}
