Facter.add(:adzone) do
  setcode do
    joined = Facter.value(:adjoined)
      if joined == true  
        Facter::Util::Resolution.exec('adinfo | grep -i zone: | awk -F \'/\' \'{print $NF}\'')
      else
        'not_joined'
      end
  end
end
