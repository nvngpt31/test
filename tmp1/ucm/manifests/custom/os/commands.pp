define ucm::custom::os::commands (
  $os = $title,
  $lookupitem,
  $commands = hiera($lookupitem) 
){
  create_resources('ucm::custom::legacy::execs', $commands)
}
