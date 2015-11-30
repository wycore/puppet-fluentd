# Configure package
#
class fluentd::config inherits fluentd {

  file { '/etc/td-agent/td-agent.conf' :
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    source  => "puppet:///modules/fluentd/td-agent.conf"
  }

  file {'/etc/td-agent/conf.d':
    ensure  => 'directory',
    owner   => 'td-agent',
    group   => 'td-agent',
    mode    => '0750',
  }

}
