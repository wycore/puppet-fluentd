# Configure a fluentd source
#
define fluentd::source (
  $ensure   = present,
  $priority = 10,
  $config   = {},
) {
  fluentd::config::file { "source-${title}":
    ensure   => $ensure,
    priority => $priority,
    content  => template( 'fluentd/source.erb'),
  }
}
