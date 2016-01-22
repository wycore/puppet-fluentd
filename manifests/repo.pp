# Configure package repository
#
class fluentd::repo inherits fluentd {
  if $::fluentd::repo_manage {
    case $::osfamily {
      'Debian': {
        include ::fluentd::repo::apt
      }
      default: {
        fail("No repo available for ${::osfamily}/${::operatingsystem}")
      }
    }
  }
}
