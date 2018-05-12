define ucm::custom::cmd (
  $path   = '/usr/ucb:/usr/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/opt/puppet/bin',
  $cmd    = $title,
  $unless = 'test -d /tmp/totallydoesnotexist',
  $runas  = 'ucmdefault', 
){

  if $runas == 'root' {
    notify {
      'msg_root_nope':
        message => "WE TOTES BAN RUNNING THINGS AS ROOT.  CONTACT 'TEAM T2 SYSTEMS MANAGEMENT ENGINEERING' FOR HELP"
    }
  }
  elsif $runas == 'ucmdefault' {
    notify {
      'msg_cmd_empty':
        message => "SKIPPING COMMAND: PLEASE PROVIDE A USER TO EXECUTE COMMAND AS"
    }
  }
  elsif $runas == 'smeucmnull' {
  }
  else {
    exec {
      "$cmd":
        path   => "$path",
        user   => "$runas",
        unless => "$unless"
    }
  }
}
