class ucm::halo::cron (
  $cronjobs = lookup('cronjobs')
){
  create_resources('ucm::custom::cron', $cronjobs)
}
