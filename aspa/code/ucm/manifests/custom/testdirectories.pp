define ucm::custom::testdirectories (
  $platform = $title,
  $lookupitem,
  $manage_these_directories = lookup("$lookupitem")
){

  create_resources('file', $manage_these_directories)
}
