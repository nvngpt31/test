class ucm::base::services (
  $services    = lookup('base::services'),

){
  create_resources('ucm::custom::services', $services)
}
