Facter.add(:arcsightserver) do

  setcode do

    print = true
    dc    = Facter.value('building')
    dom   = Facter.value('domain')
    side  = Facter.value('orientation')
    menv  = Facter.value('majorenv')
    env   = Facter.value('env')  
   
    if menv == 'nonproduction'

      domain = 'associatesys.local'
      if env == 'npe' or env == 'dev'
        server = 'arcnpeuxlog01'
      else 
        server = 'arcqauxlog01'
      end
      target = server + "." + domain

    elsif menv == 'production'

      case dc 
        when 'ct'
          server = 'arcctuxlog01'
        when 'jc', 'mw', 'ed'
          server = 'arcjcuxlog01'
        when 'tx'
          server = 'arctxuxlog01'
      end
      target = server + "." + dom
    end
  end
end
