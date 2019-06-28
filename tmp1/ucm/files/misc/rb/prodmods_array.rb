Facter.add(:prodmods_array) do
  setcode do
   mods = Facter.value(:prodmods)
   mods.split(',')
  end
end
