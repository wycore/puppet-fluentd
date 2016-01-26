# Configure a fluentd config file
# e.g. source, match etc.
#
define fluentd::config::file (
  $ensure   = present,
  $priority = 50,
  $content  = undef,
) {

  if $caller_module_name != $module_name {
    fail("Use of private fluentd::config::file by ${caller_module_name}")
  }

  $base_name   = "${title}.conf"
  $config_name = "${priority}-${base_name}"
  $config_path = "${::fluentd::conf_dir}/${config_name}"

  # clean up to ensure priority changes take effect
  exec { "apply priority change for ${base_name}":
    path    => '/bin:/usr/bin:/usr/local/bin',
    cwd     => "${::fluentd::conf_dir}",
    command => "rm *-${base_name}",
    onlyif  => "ls *-${base_name} | grep -v ${config_name}",
    before  => File[$config_path],
    notify  => Class['Fluentd::Service'],
  }

  file { $config_path:
    ensure  => $ensure,
    content => $content,
    owner   => 'td-agent',
    group   => 'td-agent',
    mode    => '0644',
    notify  => Class['Fluentd::Service'],
  }
}
