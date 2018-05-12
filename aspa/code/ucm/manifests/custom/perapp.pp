define ucm::custom::perapp (
  $app = $title,
  $ensure,
  $platform,
){

  notify { "WORKING WITH APP $app": }

  ucm::custom::perapp::directories {
    "$app":
      platform => "$platform"
  }

}

