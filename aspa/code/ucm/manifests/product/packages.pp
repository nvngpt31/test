class ucm::product::packages (
  $lookupitem            = 'packages',
  $manage_these_packages = lookup({"name" => "${lookupitem}", "default_value" => {"${::product}_ucm_default"=>{"ensure"=>"absent"}}})
){
  create_resources('package', $manage_these_packages)
}
