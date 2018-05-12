class ucm::product::limits (
  $limits = lookup('base::limits'),

){

  create_resources('ucm::custom::limits', $limits)
}
