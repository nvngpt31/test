Facter.add(:arcsightport) do
  setcode do
    menv  = Facter.value('majorenv')
    if menv == 'nonproduction'
      port = '1517'
    elsif menv == 'production'
      port = '1514'
    end
  end
end
