Facter.add(:localusers) do
    setcode do
      getentoutput = Facter::Util::Resolution.exec("cat /etc/passwd | awk -F ':' '{print $1}' | tr '\n' ',' | sed 's/.$//' ")
      getentoutput.split(',')
    end
end
