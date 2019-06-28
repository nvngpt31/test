define ucm::custom::platforms::cron (
  $platform = $title,
  $lookupitem,
  $manage_these_cron = lookup({"name" => "$lookupitem", "default_value" => {"ucm_cron_default"=>{"ensure"=>"absent"}}})
){
  create_resources('cron', $manage_these_cron)
}
