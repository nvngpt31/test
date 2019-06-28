Facter.add(:yumurl) do
  setcode do
    server = Facter.value('yumserver')
    url    = 'http://' + server + '/yumrepos/mrepo'
  end
end
