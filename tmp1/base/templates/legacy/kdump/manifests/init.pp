class kdump (
  $kdump_kernelver          = $kdump::params::kdump_kernelver,
  $kdump_commandline        = $kdump::params::kdump_commandline,
  $kdump_commandline_append = $kdump::params::kdump_commandline_append,
  $kdump_bootdir            = $kdump::params::kdump_bootdir,
  $kdump_img                = $kdump::params::kdump_img,
  $kdump_img_ext            = $kdump::params::kdump_img_ext,
  $mkdumprd_args            = $kdump::params::mkdumprd_args,
  $kexec_args               = $kdump::params::kexec_args,
  $kdumppath                = $kdump::params::kdumppath,
  $core_collector           = $kdump::params::core_collector
  )inherits kdump::params {
  class { 'kdump::config': } ->
  class { 'kdump::service': } ->
  Class ['kdump']
  }
