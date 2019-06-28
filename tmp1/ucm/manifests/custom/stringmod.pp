define ucm::custom::stringmod (
  $execpath    = hiera('execpath'),
  $tagname     = "$title",
  $path        = 'nullval',
  $replace     = 'line',
  $update      = 'all',
  $method      = 'startswith',
  $search      = 'nullval',
  $shouldbe    = 'nullval',
  $readonly    = true,
  $onlyiftrue  = 'nullval',
  $onlyiffalse = 'nullval',
  $unless      = '/bin/false',
  $backup      = false,
 
  $msg_badyaml = "Check your YAML.  Param \"method\" value is incorrect. Bailing.",
  $msg_delete  = "Currently, \"delete\" only works with the method \"startswith\" and will delete the entire line if match is found.",
  $msg_onlyif  = "Skipping \"$tagname\".  Your \"onlyif\" param did not interpolate to either \"true\" or \"false\".",
  $msg_dupe    = "File \"$path\" is already managed by a file resource.  You risk having your stringmod changes overwrittten.  Bailing.",

){


  $ro = $::gro ? {
    'on'    => true,
    'off'   => false,
    default => $readonly
  }

  # Check method, must = predefined value 
  $methodinput = $method ? {
    'startswith' => 'good',
    'endswith'   => 'good',
    'contains'   => 'good',
    'delete'     => 'good',
    default      => 'bad',
  }

  $replaceinput = $replace ? {
    'line'  => 'line',
    default => 'string',
  }

  $updateinput = $update ? {
    'all'   => 'all',
    default => 'first',
  }

  # set if either onlyiffalse or onlyiftrue is being called
  if    $onlyiftrue  != 'nullval' { $onlyifparams = 'enabled' }
  elsif $onlyiffalse != 'nullval' { $onlyifparams = 'enabled' }
  else { $onlyifparams = 'disbaled' }

  # set if either onlyif param value does not = true or false
  if $onlyifparams  == 'enabled' {
    if    $onlyiffalse == 'false' { $onlyifparamset = 'good' }
    elsif $onlyiftrue  == 'true'  { $onlyifparamset = 'good' }
    else { $onlyifparamset = 'bad' }
  }
  
  # Let them know about the way "delete" works for now.
  if $method == 'delete' {
    notify { "msg_del_${tagname}": message => "$msg_delete" }
  }
 
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Execution logic starts here.
  if $tagname == 'nullval' {}

  else {
    # Bail if method is not set to a pre defined value.
    if $methodinput != 'good' {
      notify { "msg_method_${tagname}": message => "$msg_badyaml" }
    }
    
    else {

      # Starting onlyif params logic here
      if $onlyifparams == 'enabled' {
        if $onlyifparamset != 'good' {
          notify { "msg_onlyifskip_${tagname}": message => "$msg_onlyif" } 
        }
        else {
          ucm::custom::tiers::product::stringmod {
            "$tagname":
              path     => "$path",
              method   => "$method",
              replace  => "$replaceinput",
              update   => "$updateinput",
              search   => "$search",
              shouldbe => "$shouldbe",
              readonly => $ro,
              unless   => "$unless",
              backup   => $backup,
              execpath => "$execpath",
          }
        }
      }

      else { 
        ucm::custom::tiers::product::stringmod {
          "$tagname":
            path     => "$path",
            method   => "$method",
            replace  => "$replaceinput",
            update   => "$updateinput",
            search   => "$search",
            shouldbe => "$shouldbe",
            readonly => $ro,
            unless   => "$unless",
            backup   => $backup,
            execpath => "$execpath",
        }
      }
    }
  }
}
