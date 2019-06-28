Facter.add(:yumserver) do

  setcode do

    dc    = Facter.value('building')
    dom   = Facter.value('domain')
    side  = Facter.value('orientation')
    menv  = Facter.value('majorenv')
    env   = Facter.value('env')  
   
    if menv == 'nonproduction'
      majenv = 'npe'
    else 
      majenv = 'prd'
    end
   
    if side == 'cl'
      domain = 'clientsys.local'
      asscli = 'cl'
    else 
      domain = 'associatesys.local'
      asscli = 'as'
    end 
    yumserver = 'pkg-' + majenv + '-' + dc + '-' + asscli + '-1.' + domain 
  end
end
