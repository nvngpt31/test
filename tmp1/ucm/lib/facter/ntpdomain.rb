Facter.add(:ntpdomain) do
  setcode do
    facing = Facter.value(:orientation)
      case facing
        when 'cl'
          'clientsys.local'
        when 'as'
          'associatesys.local'
      end
  end
end

