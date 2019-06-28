class ucm::legacy::directories (
  $directories = hiera('directories'),
){
  create_resources('ucm::custom::directories', $directories)
}
