class ucm::standalone::files (
  $files    = hiera('files'),

){

  notify {
    'msg_std_fle':
      message => "...MANAGING FILES"
  }

  create_resources('ucm::custom::files', $files)
}
