Facter.add(:asscli_message) do
  setcode do
    orientation_side = Facter.value(:asscli)
      case orientation_side
        when 'clientsys'
          'we_are_client_facing'
        when 'associate' 
          'we_are_associate_facing'
      end
  end
end
