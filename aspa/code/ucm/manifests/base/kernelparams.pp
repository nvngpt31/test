class ucm::base::kernelparams (
  $kernelparams = lookup('base::kernelparams')

){

  create_resources('ucm::custom::kernelparams', $kernelparams)
}

