class ucm::product::cron (
  $cronjobs = lookup('base::cronjobs')
){

  create_resources('ucm::custom::cron', $cronjobs)
}
