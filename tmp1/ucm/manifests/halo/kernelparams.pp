class ucm::halo::kernelparams (
  $kernelparams = lookup('kernelparams')

){

  create_resources('ucm::custom::kernelparams', $kernelparams)
}

