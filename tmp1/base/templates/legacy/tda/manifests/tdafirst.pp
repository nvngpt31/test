class tda::tdafirst (
  $execpath = '/usr/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin',
  $file     = '/etc/security/access.conf',

){
  exec {
    'exec_touch_access':
      path    => $execpath,
      command => "touch $file", 
      unless  => "test -f $file"
  }
}
