class ucm::base::packages (
  $packages    = lookup('base::packages'),

){
  create_resources('ucm::custom::packages', $packages)
}
