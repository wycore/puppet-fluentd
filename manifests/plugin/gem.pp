# Install fluentd gem plugins
#
define fluentd::plugin::gem (
  $ensure = present,
) {

  if $caller_module_name != $module_name {
    fail("Use of private fluentd::plugin::gem by ${caller_module_name}")
  }

  package { $name:
    ensure   => $ensure,
    provider => 'fluentd_gem',
    notify   => Class['Fluentd::Service'],
  }
}
