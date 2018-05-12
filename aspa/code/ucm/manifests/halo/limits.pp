class ucm::halo::limits (
  $limits = lookup('limits'),

){

  create_resources('ucm::custom::limits', $limits)
}
