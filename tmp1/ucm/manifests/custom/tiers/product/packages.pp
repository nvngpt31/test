define ucm::custom::tiers::product::packages (
  $package         = $title,
  $state           = 'nodef',
  $version         = 'nodef',
  $readonly            = 'true',
  $install_options = ['--verbose'],

){
  if $package == 'default' {
    notify { 'msg_pkg_def': message => "No Packages defined for base tier." }
  }
  else {
    package {
      "$package":
        ensure          => $state,
        install_options => $install_options, 
        noop            => $readonly,
    }
  } 
} 

