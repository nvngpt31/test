Facter.add(:knownusers) do
    setcode do
      getentoutput = Facter::Util::Resolution.exec("getent passwd | awk -F ':' '{print $1}' | tr '\n' ',' | sed 's/.$//' ")
      getentoutput.split(',')
    end
end
