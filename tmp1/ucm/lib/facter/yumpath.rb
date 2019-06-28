Facter.add(:yumpath) do
  setcode do
    url    = Facter.value('yumurl')
    os     = Facter.value('yumos')
    yumurl = url + '/' + os
  end
end
