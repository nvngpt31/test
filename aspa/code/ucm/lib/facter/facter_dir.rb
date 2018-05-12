Facter.add(:facter_dir) do
  setcode do
    pe_type = Facter.value(:is_pe)
      case pe_type
        when true
          '/etc/puppetlabs/facter'
        when false
          '/etc/facter'
      end
  end
end
