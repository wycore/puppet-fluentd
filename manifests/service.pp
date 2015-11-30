# Configure package
#
class fluentd::service inherits fluentd {

  if $service_manage {
    service { 'fluentd':
      name       => $service_name,
      ensure     => $service_ensure,
      enable     => $service_enable,
      hasstatus  => true,
      hasrestart => true,
    }
  }
}
