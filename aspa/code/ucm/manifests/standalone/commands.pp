class ucm::standalone::commands (
  $commands    = hiera('base::commands'),

){
  create_resources('ucm::custom::commands', $commands)
}
