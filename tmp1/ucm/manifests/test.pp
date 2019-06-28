class ucm::test (
  $ucmos = "$::ucmos",
  $repos = "${ucmos}::yumrepos"
){
  
  $yums = hiera($repos)
  create_resources('ucm::custom::yumrepo', $yums)

  

}
