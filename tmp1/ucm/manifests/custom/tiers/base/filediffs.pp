define ucm::custom::tiers::base::filediffs (
  $execpath        = lookup('execpath'),
  $path            = $title,
  $defined         = 'false',
  $owner           = 'root',
  $group           = 'root',
  $mode            = '644',
  $replace         = 'true',
  $ensure          = 'present',
  $recurse         = 'false',
  $template        = 'nodef',
  $readonly            = 'false',
  $dirtmp          = '/var/tmp/ucm',
  $modparams,

){

  if $path == '/tmp/.basefilediff' or $path == undef {
  }

  else {

    if $template == 'nodef' {
      notify { "You must provide an .epp template for this resource type.": }
    }

    else {
      $paths_in_string = split($path, '/')    
      $filename        = $paths_in_string[-1]

      # THIS TAKES THE SOURCE FILE AND CATS IT INTO ANOTHER FILE NOT INCLUDING COMMENTS, THEN SORTS IT.
      exec { 
        "concat_file_${path}":
          path    => "$execpath",
          command => "cat $path | sed '/^\s*$/d' | sed 's/[[:blank:]]*$//' | grep -v '#' | sort > ${path}.ucm_concat",
      }

      # THIS CREATES THE SOURCE FILE FROM THE PROVIDED TEMPLATE
      file {
        "${path}.ucm_template":
          ensure  => 'present',
          content => epp("$template", $modparams),
          require => Exec["concat_file_${path}"]
      }

      # THIS TAKES THE TEMPLATED SOURCE FILE AND CONCATENATES IT MINUS COMMENTS THEN SORTS IT
      exec { 
        "concat_template_${path}":
          path    => "$execpath",
          command => "cat ${path}.ucm_template | sed '/^\s*$/d' | sed 's/[[:blank:]]*$//' | grep -v '#' | sort > ${path}.ucm_source",
          require => File["${path}.ucm_template"],
      }

      # THIS COPIES THE TEMPLATED SOURCE FILE, TO THE LOCAL SOURCE FILE COPY, AND PRODUCES THE DIFF OF THE TWO
      file {
        "${path}.ucm_concat":
          ensure  => 'present',
          source  => "${path}.ucm_source",
          require => Exec["concat_template_${path}"] ,
      }

#      $removefiles = [
#        "${path}.ucm_concat", 
#        "${path}.ucm_source",   
#        "${path}.ucm_template", 
#      ]

#      $removefiles.each |String $rmfile| {
        exec {
          "rm_template_${path}":
            path    => "$execpath",
            command => "rm -f ${path}.ucm_*",
            # command => "rm -f $rmfile",
            require => File["${path}.ucm_concat"]
        }
      # }
    }
  }
}
