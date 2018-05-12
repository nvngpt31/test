Facter.add(:adjoined) do
  setcode do
    state = Facter.value(:adstate)
      if state == '0'  
        true
      else
        false
      end
  end
end
