class ucm::halo::directories (
  $directories = lookup('directories')
){
  create_resources('ucm::custom::directories', $directories)
}
