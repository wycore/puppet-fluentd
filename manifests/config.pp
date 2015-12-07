# Configure package
#
class fluentd::config inherits fluentd {

  file { $::fluentd::config_file:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    source => 'puppet:///modules/fluentd/td-agent.conf',
    notify => Class['Fluentd::Service'],
  }

  file { $::fluentd::conf_dir:
    ensure => 'directory',
    owner  => $::fluentd::user_name,
    group  => $::fluentd::user_group,
    mode   => '0750',
  }

}
