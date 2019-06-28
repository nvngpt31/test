define ucm::custom::perapp::directories (
  $ucmapp = $title,
  $platform,
){

  $perapp_dirs = lookup("${platform}::perapp::directories")

  create_resources('ucm::custom::perapp::tr_dirs', $perapp_dirs)
}
