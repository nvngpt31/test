class ucm::legacy::kernelparams (
  $kernelparams = hiera('kernelparams'),
){
  create_resources('ucm::custom::legacy::kernelparams', $kernelparams)
}
