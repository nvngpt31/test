define ucm::custom::fix::chmod (
  $execpath = 'nullval',
  $dir      = "$title",
  $mode     = '0755',

)
{

  $intmode = Integer.new($mode)

  exec {
    "mode_${dir}":
      path    => "$execpath",
      command => "chmod $intmode $dir",
  }

}
