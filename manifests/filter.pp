# Configure a fluentd filter
#
define fluentd::filter (
  $ensure   = present,
  $priority = 20,
  $pattern  = '',
  $config   = {},
) {
  fluentd::config::file { "filter-${title}":
    ensure   => $ensure,
    priority => $priority,
    content  => template( 'fluentd/filter.erb'),
  }
}
