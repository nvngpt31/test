class ucm::onetime {

  if $::onetimename == undef {
    notify { 'Class ucm::onetime requires the fact "onetimename" = the vaue of a data module with name::type hashes.  Bailing.': }
  }

  else {

    if $::onetimerun == 'true' {
      class {
        'ucm::tools':
           onetime => $::onetimename
      }
    }

    else {
      notify { "Not running Class ucm::onetime because fact onetimerun = true is not present for this node $::hostname": }
    }
  }
}
