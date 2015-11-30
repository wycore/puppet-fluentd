class fluentd::params {
  $ensure = 'present'

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
