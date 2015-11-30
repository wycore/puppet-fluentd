class fluentd::params {
  $ensure                  = 'present'

  $package_ensure          = 'installed'
  $package_name            = 'td-agent'
  $package_install_options = []

  case $::osfamily {
    'Debian': {
      case $::operatingsystem {
        'Ubuntu': {
          $manage_repo = true
        }
        default: {
          fail("Unsupported osfamily: ${::operatingsystem}")
        }
      }
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily}")
    }
  }
}
