Facter.add(:yumos) do
  setcode do
    is_el6 = Facter.value('is_el6')  
    if is_el6 == true
      yumos = 'rhel-6-x86_64'
    else 
      yumos = 'rhel-7-x86_64'
    end
  end
end
