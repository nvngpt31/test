define ucm::custom::os::files (
  $os = $title,
  $lookupitem,
  $manage_these_files = hiera($lookupitem)
){
  create_resources('ucm::custom::legacy::files', $manage_these_files)
}
