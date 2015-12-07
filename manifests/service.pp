# Configure package
#
class fluentd::service inherits fluentd {

  if $::fluentd::service_manage {
    service { 'fluentd':
      ensure     => $::fluentd::service_ensure,
      name       => $::fluentd::service_name,
      enable     => $::fluentd::service_enable,
      hasstatus  => true,
      hasrestart => true,
    }
  }
}
