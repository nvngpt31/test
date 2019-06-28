class ucm::legacy::stringmod (
  $lookupitem,

){

  $strmods = hiera($lookupitem)
  # ensures package python and udpates stringmod script
  contain ucm::custom::stringmodreq
  create_resources('ucm::custom::stringmod', $strmods)

}
