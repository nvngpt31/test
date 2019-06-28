# ----- Mapping 
# class  ucm::base
# class    |_ucm::base::main 
# define     |_ucm::base::custom::groups
# define     |__ucm::custom::tiers::base::groups
# define     |_ucm::base::custom::users
# define     |__ucm::custom::tiers::base::users
# define     |_ucm::base::custom::packages
# define     |__ucm::custom::tiers::base::packages
# define     |_ucm::base::custom::directories
# define     |__ucm::custom::tiers::base::directories
# define     |_ucm::base::custom::files
# define     |__ucm::custom::tiers::base::files
# define     |_ucm::base::custom::services
# define     |__ucm::custom::tiers::base::services
# -----

class ucm::base { 
  tag 'ucm_base'

  class { 
    'ucm::base::pre': 
  }

  class { 
    'ucm::base::main': 
      require => Class['ucm::base::pre']
  }
}
      

