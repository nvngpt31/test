class ucm::masterlesstest (
  $ucmfoo = lookup('ucmfoo'),
){
  notify {
    'msgmasterlesstst':
      message => "... testing the local setup of Puppet to run masterless on this server: $::hostname"
  }

  notify {
    'msgmasterlesstst_lookup':
      message => "... dataitem 'ucmfoo' is in common.yaml.  Attempting to look it up now: ucmfoo = $ucmfoo",
      require => Notify['msgmasterlesstst']
  }
}

