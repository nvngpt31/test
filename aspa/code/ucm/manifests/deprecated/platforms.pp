class ucm::platforms (
  $platforms = lookup('platforms')
){
  notify {
    'MSGPLATFORMS':
      message => 'MANAGING PLATFORM CONFIG IF ANY...'
  }

  create_resources('ucm::custom::platforms', $platforms)
}
