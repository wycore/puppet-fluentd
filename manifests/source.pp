# Configure a fluentd source
#
define fluentd::source (
  $ensure   = present,
  $priority = 10,
  $config   = {},
) {

  # parameter validation
  if ! ($ensure in [ 'present', 'absent' ]) {
    fail('ensure parameter must be present or absent')
  }
  validate_integer($priority)
  validate_hash($config)

  fluentd::config::file { "source-${title}":
    ensure   => $ensure,
    priority => $priority,
    content  => template( 'fluentd/source.erb'),
  }
}
