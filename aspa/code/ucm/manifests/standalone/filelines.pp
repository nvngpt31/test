class ucm::standalone::filelines (
  $filelines    = hiera('base::filelines'),

){
  create_resources('ucm::custom::fileline', $filelines)
}
