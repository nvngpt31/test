class ucm::product::packages (
  $lookupitem            = 'packages',
  $manage_these_packages = lookup({"name" => "${lookupitem}", "default_value" => {"${::product}_ucm_default"=>{"ensure"=>"absent"}}, "merge" => "deep"})
){
  create_resources('ucm::custom::packages', $manage_these_packages)
}
