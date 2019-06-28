class ucm::legacy::sysctl (
  $lookupitem,

){

  $sysctl = hiera($lookupitem)
  # ensures package python and udpates stringmod script
  create_resources('ucm::custom::sysctl', $sysctl)

}
