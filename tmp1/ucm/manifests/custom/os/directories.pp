define ucm::custom::os::directories (
  $os = $title,
  $lookupitem,
  $manage_these_directories = hiera($lookupitem)
){
  create_resources('ucm::custom::directories', $manage_these_directories)
}
