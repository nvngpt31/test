class ucm::halo::packages (
  $packages    = lookup('packages'),

){
  create_resources('ucm::custom::packages', $packages)
}
