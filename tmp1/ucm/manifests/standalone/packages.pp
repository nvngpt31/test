class ucm::standalone::packages (
  $packages = hiera('packages')

){

  notify {
    'msg_std_pkgs':
      message => "...MANAGING PACKAGES"
  }

  create_resources('package', $packages)
}
