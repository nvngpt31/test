class ucm::product::filelines (
  $filelines    = lookup('base::filelines'),

){
  create_resources('ucm::custom::fileline', $filelines)
}
