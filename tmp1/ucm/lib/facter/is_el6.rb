Facter.add(:is_el6) do
  setcode do
    osmajrel = Facter.value(:operatingsystemmajrelease)
      case osmajrel
        when '6'
          true
        else
          false
      end
  end
end

