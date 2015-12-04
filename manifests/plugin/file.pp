# Install fluentd file plugins
#
define fluentd::plugin::file (
  $ensure = present,
  $source = undef,
) {

  if $caller_module_name != $module_name {
    fail("Use of private fluentd::plugin::file by ${caller_module_name}")
  }

  file { "${::fluentd::config_path}/plugin/${name}":
    ensure => $ensure,
    owner  => $::fluentd::user_name,
    group  => $::fluentd::user_group,
    mode   => '0640',
    source => $source,
    notify => Class['Fluentd::Service']
  }
}
