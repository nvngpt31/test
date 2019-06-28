Facter.add(:vm_appvg_available) do
  confine :vm_appvg_present => 'true'
    setcode do
    Facter::Util::Resolution.exec('vgs | grep appvg | awk \'{print $7}\'')
  end
end
