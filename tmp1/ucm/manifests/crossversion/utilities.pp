class ucm::crossversion::utilities {

  file {
    "/usr/local/bin/ucm-manage-sysctl":
      ensure  => 'present',
      mode    => "0700",
      owner   => 'root',
      group   => 'root',
      content => template("ucm/bin/ucm-manage-sysctl.erb") 
  }  

}
