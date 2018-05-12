class ucm::product::commands (
  $commands    = lookup('base::commands'),

){
  create_resources('ucm::custom::commands', $commands)
}
