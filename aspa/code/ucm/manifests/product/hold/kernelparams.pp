class ucm::product::kernelparams (
  $kernelparams = lookup('base::kernelparams')

){

  create_resources('ucm::custom::kernelparams', $kernelparams)
}

