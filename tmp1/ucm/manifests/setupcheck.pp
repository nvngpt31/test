class ucm::setupcheck (

  $ucmfoo  = lookup('ucmfoo'),
  $testfoo = lookup('testfoo')

){

  notice("This is a test to make sure things work correctly.")
  notice("If the value proceeding the = is blank, something is off.  Hostname fact = $::hostname")
  notice("If the value proceeding the = is blank, something is off.  testfoo param in base/data/global.yaml = $testfoo")
  notice("If the value proceeding the = is blank, something is off.  ucmfoo param in data/common.yaml = $ucmfoo")

}
