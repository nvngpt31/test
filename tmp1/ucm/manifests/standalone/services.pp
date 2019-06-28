class ucm::standalone::services (
  $services    = hiera('base::services'),

){
  create_resources('ucm::custom::services', $services)
}
