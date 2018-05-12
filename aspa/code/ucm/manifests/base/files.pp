class ucm::base::files (
  $files    = lookup('base::files'),

){
  create_resources('ucm::custom::files', $files)
}
