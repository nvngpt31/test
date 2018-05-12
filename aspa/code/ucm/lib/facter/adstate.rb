Facter.add("adstate") do
  setcode do
    Facter::Util::Resolution.exec('adinfo > /dev/null 2>&1 ; echo $?')
  end
end

