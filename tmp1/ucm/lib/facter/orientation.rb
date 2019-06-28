Facter.add(:orientation) do
  setcode do
    face = Facter.value(:asscli)
      case face
        when 'clientsys'
          'cl'
        when 'associate' 
          'as'
      end
  end
end

