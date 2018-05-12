define ucm::custom::apps (
  $app = $title,
  $ensure,
  $platform,

){

  if $app == 'null' {
  }
 
  else {
    # RUN THE PER APP CONFIG FOR EACH APP INSTANCE 
    ${platform}::perapp {
      "${app}":
        ensure   => "$ensure",
    }
  }
}
