# Install fluentd plugins
#
define fluentd::plugin (
  $ensure = present,
  $type   = 'gem',
  $source = undef,
) {

  # parameter validation
  if ! ($ensure in [ 'present', 'absent' ]) {
    fail('ensure parameter must be present or absent')
  }

  case $type {
    'gem': {
      fluentd::plugin::gem { $name:
        ensure => $ensure,
        require => Class['Fluentd::Install']
      }
    }
    'file': {
      validate_string($source)

      fluentd::plugin::file { $name:
        ensure => $ensure,
        require => Class['Fluentd::Install']
      }
    }
    default: {
      fail("plugin type: '${type}' is currently not supported, use gem or file")
    }
  }
}
