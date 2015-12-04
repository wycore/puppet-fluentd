# Install fluentd file plugins
#
define fluentd::plugin::file (
  $ensure = present,
  $source = undef,
) {

  if $caller_module_name != $module_name {
    fail("Use of private fluentd::plugin::file by ${caller_module_name}")
  }

  file { "/etc/td-agent/plugin/${name}":
    ensure => $ensure,
    owner  => 'td-agent',
    group  => 'td-agent',
    mode   => '0640',
    source => $source,
    notify => Class['Fluentd::Service']
  }
}
