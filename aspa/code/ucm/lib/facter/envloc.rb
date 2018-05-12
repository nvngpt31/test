Facter.add("envloc") do
  setcode do
    Facter::Util::Resolution.exec('hostname -f | cut -c 1-5')
  end
end
