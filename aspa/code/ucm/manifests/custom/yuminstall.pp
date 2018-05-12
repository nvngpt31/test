define ucm::custom::yuminstall (
  $path    = lookup('execpath'),
  $package = $title,

){

  exec {
    "install_package_${package}":
      path    => "$path",
      command => "yum install -y $package"
  }

}
