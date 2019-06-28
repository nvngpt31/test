1.setfact:
  cmd.run:
    - name: "echo 'runbase=true' > /etc/facter/facts.d/runbase.txt"

2.logger:
  cmd.run:
    - name: 'logger "Sleeping then Running ucm::base Puppet Class"'
    - require:
      - cmd: 1.setfact

3.runagent:
  cmd.run:
    - name: 'sleep `shuf -i1-10800 -n1` && /opt/puppetlabs/puppet/bin/puppet agent -t --tags ucm::base &>/dev/null &disown'
    - require:
      - cmd: 2.logger

