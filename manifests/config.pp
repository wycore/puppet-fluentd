# Configure package
#
class fluentd::config inherits fluentd {

  file { $config_file:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    source  => "puppet:///modules/fluentd/td-agent.conf",
    notify  => Class['Fluentd::Service'],
  }

  file { $conf_dir:
    ensure  => 'directory',
    owner   => $user_name,
    group   => $user_group,
    mode    => '0750',
  }

}
