Facter.add(:is_el7) do
  setcode do
    osmajrel = Facter.value(:operatingsystemmajrelease)
      case osmajrel
        when '7'
          true
        else
          false
      end
  end
end

