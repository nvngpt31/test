class ucm::sme::baseline (
  $schedulehash = lookup('schedule')
){

  if $product == 'ucm' {
    if $child == 'schedule' {

      create_resources('ucm::custom::tiers::base::backend_cron', $schedulehash)

    }
   
    else {
      notify { "Child fact not schedule or not defined.  Bailing.": }
    }
  }

  else {
    notify { "Product fact not ucm or not defined.  Bailing.": }
  }

}
