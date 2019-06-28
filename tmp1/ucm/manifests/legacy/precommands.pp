class ucm::legacy::precommands (
  $commands = hiera('legacy::precommands')
){
  create_resources('ucm::custom::legacy::precommands', $commands)
}
