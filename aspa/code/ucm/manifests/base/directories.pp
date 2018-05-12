class ucm::base::directories (
  $directories = lookup('base::directories')
){
  create_resources('file', $directories)
}
