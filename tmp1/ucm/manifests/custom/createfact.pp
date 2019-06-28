define ucm::custom::createfact (
  $fact  = $title,
  $value = 'true',
  $fdir  = "/etc/facter/facts.d",

){

  $fact_template = @("END")
  ${fact}=${value}
  | END

  file {
    "${fdir}/${fact}.txt":
      ensure  => 'present',
      content => inline_template($fact_template)
  }
}

