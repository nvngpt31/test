class kdump::params {
  #variables for /etc/sysconfig/kdump
  $kdump_kernelver          = ''
  $kdump_commandline        = ''
  $kdump_commandline_append = 'rqpoll nr_cpus\=1 reset_devices cgroup_disable\=memory'
  $kdump_bootdir            = '/boot'
  $kdump_img                = 'vmlinuz'
  $kdump_img_ext            = ''
  if $is_virtual == 'true' {
  $mkdumprd_args            = '--builtin=vsock'
  }
  else {
  $mkdumprd_args            = ''
  }
  $kexec_args               = ''

  #variables for /etc/kdump.conf
  $kdumppath      = 'path /var/crash'
  $core_collector = 'core_collector makedumpfile -c --message-level 1 -d 31'
}
