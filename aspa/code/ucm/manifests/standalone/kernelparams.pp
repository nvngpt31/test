class ucm::standalone::kernelparams (
  $kernelparams = hiera('base::kernelparams')

){

  create_resources('ucm::custom::kernelparams', $kernelparams)
}

