Facter.add(:yumkeymain) do
  setcode do
    url = Facter.value('yumurl')
    key = url + '/' + 'gpgkeys/RPM-GPG-KEY-redhat' 
  end
end
