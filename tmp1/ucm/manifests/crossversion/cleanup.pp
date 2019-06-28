class ucm::crossversion::cleanup (

  $execpath = '/bin:/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin'

)
{

  exec {
    "cleanup_old_repos_foreman":
      path    => "$execpath",
      command => "rm -f /etc/yum.repos.d/*foreman*", 
      onlyif  => "ls /etc/yum.repos.d/ | grep -q foreman";

    "cleanup_old_repos_pe":
      path    => "$execpath",
      command => "rm -f /etc/yum.repos.d/*pe-*",
      onlyif  => "ls /etc/yum.repos.d/ | grep -q ^pe-";
     

    "cleanup_old_repos_puppet":
      path    => "$execpath",
      command => "rm -f /etc/yum.repos.d/*puppet*", 
      onlyif  => "ls /etc/yum.repos.d/ | grep -q puppet";
  }

}
