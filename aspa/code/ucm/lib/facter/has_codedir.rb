Facter.add("has_codedir") do
  setcode do
    Facter::Util::Resolution.exec('test -d /etc/puppetlabs/code > /dev/null 2>&1 ; echo $?')
  end
end
