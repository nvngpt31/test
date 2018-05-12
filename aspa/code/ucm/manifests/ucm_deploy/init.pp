class local (
  $envstate = hiera('envstate')
){
  
  create_resources('local::gitsync', $envstate)

}
