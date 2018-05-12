class ucm::platforms {
  tag 'ucm_platforms'

  if $::smeucmplatform == undef {
  }

  else {

  $platform              = "${::smeucmplatform}"
  $platform_groups       = "${::smeucmplatform}::groups"
  $platform_users        = "${::smeucmplatform}::users"
  $platform_packages     = "${::smeucmplatform}::packages"
  $platform_directories  = "${::smeucmplatform}::directories"
  $platform_files        = "${::smeucmplatform}::files"
  $platform_links        = "${::smeucmplatform}::links"
  $platform_limits       = "${::smeucmplatform}::limits"

  ucm::custom::platforms::groups {
    "$platform":
      lookupitem => "$platform_groups"
  }

  ucm::custom::platforms::users {
     "$platform":
      lookupitem => "$platform_users",
      require    => Ucm::Custom::Platforms::Groups["$platform"]
   }

  ucm::custom::platforms::packages {
    "$platform":
      lookupitem => "$platform_packages",
      require    => Ucm::Custom::Platforms::Users["$platform"]
  }

  ucm::custom::platforms::directories {
    "$platform":
      lookupitem => "$platform_directories",
      require    => Ucm::Custom::Platforms::Packages["$platform"]
  }

  ucm::custom::platforms::files {
     "$platform":
      lookupitem => "$platform_files",
      require    => Ucm::Custom::Platforms::Directories["$platform"]
  }

  ucm::custom::platforms::links {
    "$platform":
      lookupitem => "$platform_links",
      require    => Ucm::Custom::Platforms::Files["$platform"]
  }

  ucm::custom::platforms::limits {
    "$platform":
      lookupitem => "$platform_limits",
      require    => Ucm::Custom::Platforms::Links["$platform"]
  }
  }
}
