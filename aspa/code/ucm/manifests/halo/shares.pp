class ucm::halo::shares (
  $shares    = lookup('shares'),

){
  create_resources('ucm::custom::shares', $shares)
}
