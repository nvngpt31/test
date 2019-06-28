class ucm::legacy::packages (
  $packages = hiera('packages'),
){
  create_resources('package', $packages)
}
