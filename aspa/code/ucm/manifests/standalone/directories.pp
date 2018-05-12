class ucm::standalone::directories (
  $directories = hiera('directories')

){
  notify {
    'msg_std_dir':
      message => "...MANAGING DIRECTORIES"
  }

  create_resources('file', $directories)
}
