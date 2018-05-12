class ucm::base (
){ 

  notify {
    'msg_base':
      message => "...APPLYING BASE TIER",
  }
  
  class {
    'ucm::base::main':
      require => Notify['msg_base']
  }
}
