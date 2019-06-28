case <%= @host.environment %> in
staging|nonproduction)
if [ "$asscli" == "associate" ]; then
    asscli="associatesys"
else
    asscli="clientsys"
fi

puppetconf="/etc/puppet/puppet.conf"
puppetpkg="puppet-3.4.3-1.el6"

# update system
yum clean all && yum makecache
yum -t -y -e 0 update

# add puppet repos
yum-config-manager --enable puppet
yum-config-manager --enable puppetdeps
yum-config-manager --enable epel

yum clean all && yum makecache
yum -t -y -e 0 install $puppetpkg

echo "Configuring puppet"
cat > /etc/puppet/puppet.conf << EOF
#kind: snippet
#name: puppet.conf
<%= snippets "puppet.conf" %>
EOF
;;
production)
if [ "$asscli" == "associate" ] ; then
    asscli="associatesys"
else
    asscli="clientsys"
fi

puppetconf="/etc/puppetlabs/puppet/puppet.conf"
puppetpkg="pe-agent-3.2.0-1.pe.el6"

# update system
yum clean all && yum makecache
yum -t -y -e 0 update

# add pe-puppet repos
yum-config-manager --enable pe-puppet
yum clean all && yum makecache
yum -t -y -e 0 install $puppetpkg pe-hiera pe-ruby-augeas pe-augeas pe-mcollective pe-mcollective-common pe-ruby-ldap pe-ruby-rgen pe-ruby-shadow pe-ruby-stomp pe-rubygem-deep-merge pe-rubygem-net-ssh

touch /opt/puppet/pe_version
cat << PEV >> /opt/puppet/pe_version               
PEV

cd /usr/local/bin
/bin/ln -s /opt/puppet/bin/facter facter
/bin/ln -s /opt/puppet/bin/hiera hiera
/bin/ln -s /opt/puppet/bin/mco mco
/bin/ln -s /opt/puppet/bin/pe-man pe-man
/bin/ln -s /opt/puppet/bin/puppet puppet
chmod 755 /opt/puppet

cat > /etc/puppetlabs/puppet/puppet.conf << EOF

<%= snippets "pe_puppet.conf"  %>

EOF
;;
*)
esac
