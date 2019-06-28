class tda::cron (
  $users = hiera('cronusers'),
){
  create_resources('tda::cron::user', $users)
}
