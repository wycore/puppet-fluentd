# Configure package
#
class fluentd::user inherits fluentd {

  if $::fluentd::user_manage {
    user { 'fluentd':
      name    => $::fluentd::user_name,
      gid     => $::fluentd::user_group,
      groups  => $::fluentd::user_groups,
      require => Class['Fluentd::Install'],
    }
  }
}
