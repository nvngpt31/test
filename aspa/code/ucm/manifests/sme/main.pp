class ucm::sme::main (
){
  tag 'ucm_sme_main'

  if $::product != undef {
    $apps  = lookup('apps')
    $tools = lookup('tools')
    create_resources('ucm::custom::touchapp', $apps)
    create_resources('ucm::custom::touchtool', $tools)
  }

  else {
    notify {
      'msg_blank':
        message => err('...PRODUCT NOT DEFINED, SKIPPING.')
    }
  }
}
