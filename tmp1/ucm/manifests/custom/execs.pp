define ucm::custom::execs (
  $command      = '/bin/false',
  $tagname      = $title,
  $defined      = 'false',
  $path         = lookup('execpath'),
  $flag         = "/etc/facter/facts.d/flag_${tagname}.txt",
  $runas        = 'nouser',
  $requiretag   = "empty",
  $unless       = "/bin/false",       
  $readonly     = true,

){

  $ro = $::gro ? {
    'on'    => true,
    'off'   => false,
    default => $readonly
  }

  if $tagname == 'blank' or $tagname == 'void' {
  }

  else {

    # THIS IS CURRENTLY THE ONLY CONDITION TO NOT RUN SOMETHING AS ROOT.
    # THIS NEEDS TO BE MOVED TO A HASHI TYPE METHOD FOR A TOKEN OR KEY BASED ENABLEMENT (PS IS THAT A WORD?)
    if $runas == 'root' and $::voidexecs != 'true' {
      notify { "Tagname: $tagname - not able to run as root.": }
    }

    elsif $runas == 'nouser' {
      notify { "Tagname: $tagname - please provide user to run as.": }
    }

    elsif $runas == 'null' {
    }

    else {
      if $requiretag != 'empty' {
        exec {
          "exec_for_$tagname":
            path       => $path,
            user       => $runas,
            command    => "$command",
            unless     => "$unless",
            require    => Exec["$requiretag"],
            noop       => $ro,
        }
      }

      else {
        exec {
          "exec_for_$tagname":
            path    => $path,
            user    => $runas,
            command => "$command",
            unless  => "$unless",
            noop    => $ro,
        }
      }

#      file {
#        "$flag":
#          ensure  => 'present',
#          noop    => $ro,
#          require => Exec["exec_for_$tagname"]
#      }
    }
  }
}

