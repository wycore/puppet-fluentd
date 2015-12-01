# Configure a fluentd config file
# e.g. source, match etc.
#
define fluentd::config::file (
  $ensure   = present,
  $priority = 50,
  $content,
) {

  $base_name   = "${title}.conf"
  $config_name = "${priority}-${base_name}"
  $base_path   = "/etc/td-agent/conf.d"
  $config_path = "${base_path}/${config_name}"

  # clean up to ensure priority changes take effect
  exec { "apply priority change for ${base_name}":
    command => "rm ${base_path}/*-${base_name}",
    onlyif => "ls ${base_path}/*-${base_name} | grep -v ${config_name}",
    before  => File[$config_path],
    notify  => Class['fluentd::service'],
  }

  file { $config_path:
    ensure  => $ensure,
    content => $content,
    owner   => 'td-agent',
    group   => 'td-agent',
    mode    => '0644',
    notify  => Class['fluentd::service'],
  }
}
