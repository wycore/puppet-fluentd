# Configure a fluentd filter
#
define fluentd::filter (
  $ensure   = present,
  $priority = 20,
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

  fluentd::config::file { "filter-${title}":
    ensure   => $ensure,
    priority => $priority,
    content  => template( 'fluentd/filter.erb'),
  }
}
