class ucm::halo::services (
  $services    = lookup('services'),

){
  create_resources('ucm::custom::services', $services)
}
