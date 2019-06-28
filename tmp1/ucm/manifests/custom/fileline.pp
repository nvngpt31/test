define ucm::custom::fileline (
  $line    = $title,
  $defined = 'false',
  $path    = 'blank',

){

  if $line == 'blank' {
    #    notify {
    #  'msg_lne_blank':
    #    message => '...NOT MANAGING ANY LINES IN FILES AT THIS TIME'
    #}
  }

  else {
    file_line {
      "line_${line}_${path}":
        path => $path,
        line => $line
    }
  }
}
