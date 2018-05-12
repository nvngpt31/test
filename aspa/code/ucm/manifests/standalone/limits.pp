class ucm::standalone::limits (
  $limits = hiera('base::limits'),

){

  create_resources('ucm::custom::limits', $limits)
}
