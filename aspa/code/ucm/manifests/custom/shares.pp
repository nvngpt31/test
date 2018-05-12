define ucm::custom::shares (
  $path       = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/opt/puppetlabs/bin:/root/bin',
  $mountpoint = $title,
  $user       = 'root',
  $group      = 'root',
  $share      = 'nodef',
  $state      = 'mounted',
  $defined    = 'false',
  $fstype     = 'nfs',

){

  if $mountpoint == 'blank' {
    #    notify {
    #  'msg_shr_blank':
    #    message => '...NO NFS SHARES TO MANAGE AT THIS TIME'
    #}
  }

  else {

    if defined(File[$mountpoint]) {
      notify { 
        "msg_mnt_managed":
          message => "...MOUNTPOINT MANAGED BY ANOTHER CLASS, PROCEEDING TO MOUNT",
          before  => Mount[$mountpoint]
      }
    }

    else {
      file {
        "$mountpoint":
          ensure => 'directory',
          mode   => "0755",
          before => Mount[$mountpoint]
      }
    }

    mount {
      "$mountpoint":
        device  => "$share",
        fstype  => "$fstype",
        ensure  => "mounted",
        options => "defaults",
        atboot  => true,
    }

    #exec {
    #  "sleep_${mountpoint}":
    #    command => "/usr/bin/sleep 15",
    #    require => Mount["$mountpoint"]
    #}

    #exec {
    #  "mount_${mountpoint}":
    #    command => "/bin/mount $share $mountpoint",
    #    #require => Exec["sleep_${mountpoint}"]
    #    require => Mount["$mountpoint"]
    #}

    exec {
      "chownage_${mountpoint}":
        path     => "$path",
        command  => "chown ${user}.${group} $mountpoint",
        unless   => "stat -c '%U' ${mountpoint} | grep -q ${user}",
        #require  => Exec["mount_${mountpoint}"]
        require => Mount["$mountpoint"]
    }
  }
}
