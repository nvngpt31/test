Facter.add("prodmods") do
  setcode do
    Facter::Util::Resolution.exec('sh /usr/local/bin/prodmods')
  end
end

