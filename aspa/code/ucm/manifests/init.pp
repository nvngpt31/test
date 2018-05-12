class ucm (
){

  notify {
    'msg_running':
      message => "...RUNNING UCM CLASS"
  }

  if $::product == undef {
    notify {
      'msg_nodef':
        message => "ERROR: PRODUCT FACT IS NOT DEFINED IN FOREMAN OR LOCALLY, BAILING."
    }
  }

  else {
    class { 
      "ucm::product": 
        require => Notify['msg_running']
    }
  }
}
