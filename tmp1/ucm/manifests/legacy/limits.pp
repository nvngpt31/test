class ucm::legacy::limits (
  $limits = hiera('limits'),
){
  create_resources('ucm::custom::legacy::limits', $limits)
}
