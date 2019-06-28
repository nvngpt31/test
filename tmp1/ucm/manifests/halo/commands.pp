class ucm::halo::commands (
  $commands    = lookup('commands'),

){
  create_resources('ucm::custom::commands', $commands)
}
