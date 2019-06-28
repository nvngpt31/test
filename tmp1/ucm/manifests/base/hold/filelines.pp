class ucm::base::filelines (
  $filelines    = lookup('base::filelines'),

){
  create_resources('ucm::custom::fileline', $filelines)
}
