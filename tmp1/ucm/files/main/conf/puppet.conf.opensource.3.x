[main]
    logdir = /var/log/puppet
    rundir = /var/run/puppet
    ssldir = /ssl
    privatekeydir = /private_keys { group = service }
    hostprivkey = /.pem { mode = 640 }
    autosign       = /autosign.conf { mode = 664 }
    ca_server = puppet-ca.associatesys.local
[agent]
    classfile = /classes.txt
    localconfig = /localconfig
    default_schedules = false
    report        = true
    pluginsync    = true
    masterport    = 8140
    environment   = nonproduction
    certname      = MYFQDN
    server        = MYMASTER
    listen        = false
    splay         = false
    runinterval   = 1800
    noop          = false
    show_diff     = false
    configtimeout = 120

