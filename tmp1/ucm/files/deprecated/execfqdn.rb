Facter.add("execfqdn") do
  setcode do
    Facter::Util::Resolution.exec('hostname -f')
  end
end
