# Configure a fluentd match
#
define fluentd::match (
  $ensure   = present,
  $priority = 30,
  $pattern  = '',
  $config   = {},
) {

  # parameter validation
  if ! ($ensure in [ 'present', 'absent' ]) {
    fail('ensure parameter must be present or absent')
  }
  validate_integer($priority)
  validate_string($pattern)
  validate_hash($config)

  fluentd::config::file { "match-${title}":
    ensure   => $ensure,
    priority => $priority,
    content  => template( 'fluentd/match.erb'),
  }
}
