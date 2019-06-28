class ucm::sme::main (
){
  tag 'ucm_sme_main'

  if $::product != undef {
    $apps  = lookup('apps')
    $tools = lookup('tools')
    create_resources('ucm::custom::touchapp', $apps)
    create_resources('ucm::custom::touchtool', $tools)

    ucm::sme::customfacts {
      "customfacts":
        lookupitem => "customfacts"
    }

  }

  else {
    notify {
      'msg_blank':
        message => err('...PRODUCT NOT DEFINED, SKIPPING.')
    }
  }

  file {
    "/usr/local/bin/ucm-access.conf.setup.sh":
      ensure  => 'present',
      mode    => '0775',
      content => epp("ucm/base/system/access.conf.setup.sh.epp"),
  }

  file {
    "/usr/local/bin/ignoreuser":
      ensure  => 'present',
      mode    => '0775',
      content => epp("ucm/base/system/ignoreuser.epp"),
  }
}
