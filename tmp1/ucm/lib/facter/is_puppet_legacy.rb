Facter.add(:is_puppet_legacy) do
  setcode do
    node_has_codedir = Facter.value(:has_codedir)
      if node_has_codedir == '0'  
        false
      else
        true
      end
  end
end
