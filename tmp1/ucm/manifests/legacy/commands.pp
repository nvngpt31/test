class ucm::legacy::commands (
  $commands = hiera('legacy::commands')
){
  create_resources('ucm::custom::legacy::commands', $commands)
}
