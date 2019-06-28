Facter.add("has_mw_legacy_jdk") do
  setcode do
    if File.exist?('/app/java/jdk1.7.0_67')
      has_mw_legacy_jdk = true
    elsif File.exist?('/app/java/jdk1.8.0_20')
      has_mw_legacy_jdk = true
    else has_mw_legacy_jdk = false
    end
  end
end

