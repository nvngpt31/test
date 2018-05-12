class ucm::apps (
  $apps = lookup('apps')
){
  notify {
    'MSGAPPS':
      message => 'MANAGING APP SPECIFIC PLATFORM CONFIG IF ANY...'
  }

  create_resources('ucm::custom::platforms', $apps)
}
