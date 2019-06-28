define ucm::custom::os::packages (
  $os = $title,
  $lookupitem,
  $manage_these_packages = hiera($lookupitem)
){
  create_resources('ucm::custom::packages', $manage_these_packages)
}
