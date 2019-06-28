class ucm::legacy::provisioning (
){

  notify { 'msg_legtest': message => "... Running legacy facts class." }
  class  { 'facts': require => Notify['msg_legtest'] }

  notify { 'msg_legtest2': message => "... Running legacy postfix class." }
  class  { 'postfix': require => Notify['msg_legtest2'] }

  notify { 'msg_legtest3': message => "... Running legacy tdavmtools class." }
  class  { 'tdavmtools': require => Notify['msg_legtest3'] }

}
