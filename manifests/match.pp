# Configure a fluentd match
#
define fluentd::match (
  $ensure   = present,
  $priority = 30,
  $pattern  = '',
  $config   = {},
) {
  fluentd::config::file { "match-${title}":
    ensure   => $ensure,
    priority => $priority,
    content  => template( 'fluentd/match.erb'),
  }
}
