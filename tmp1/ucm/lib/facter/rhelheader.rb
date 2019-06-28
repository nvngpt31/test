Facter.add(:rhelheader) do
  setcode do
    is_el6 = Facter.value('is_el6')  
    if is_el6 == true
      header = 'rhel6'
    else 
      header = 'rhel7'
    end
  end
end
