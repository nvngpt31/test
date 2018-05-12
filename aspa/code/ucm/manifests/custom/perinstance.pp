define ucm::custom::perinstance (
  $instance = $title,
  $platform = 'null',

){

  if $platform == 'null' {
  }
 
  else {
    $perinstance_groups       = "${platform}::perinstance::groups"
    $perinstance_users        = "${platform}::perinstance::users"
    $perinstance_packages     = "${platform}::perinstance::packages"
    $perinstance_directories  = "${platform}::perinstance::directories"
    $perinstance_files        = "${platform}::perinstance::files"

    ucm::custom::perinstance::groups {
      "$platform":
        lookupitem => "$perinstance_groups"
    }

    ucm::custom::perinstance::users {
      "$platform":
        lookupitem => "$perinstance_users",
        require    => Ucm::Custom::Tools::Groups["$platform"]
    }

    ucm::custom::perinstance::packages {
      "$platform":
        lookupitem => "$perinstance_packages",
        require    => Ucm::Custom::Tools::Users["$platform"]
    }

    ucm::custom::perinstance::directories {
      "$platform":
        lookupitem => "$perinstance_directories",
        require    => Ucm::Custom::Tools::Packages["$platform"]
    }

    ucm::custom::perinstance::files {
      "$platform":
        lookupitem => "$perinstance_files",
        require    => Ucm::Custom::Tools::Directories["$platform"]
    }
  }
}
