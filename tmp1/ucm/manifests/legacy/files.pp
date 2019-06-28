class ucm::legacy::files (
  $files = hiera('files'),
){
  create_resources('ucm::custom::legacy::files', $files)
}
