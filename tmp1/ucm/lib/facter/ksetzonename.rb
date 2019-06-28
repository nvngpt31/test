Facter.add("ksetzonename") do
  setcode do
    if File.exist?('/var/centrifydc/kset.zonename')
      ksetcontent = File.read('/var/centrifydc/kset.zonename')
      ksetarray = ksetcontent.split(',')
      ksetzone = ksetarray[0].partition('=').last
    else 
      ksetzone = 'not_joined' 
    end
  end
end
