# Configure package repository
#
class fluentd::repo {
  case $::osfamily {
    'Debian': {
      include ::fluentd::repo::apt
    }
    default: {
      fail("No repo available for ${::osfamily}/${::operatingsystem}")
    }
  }
}