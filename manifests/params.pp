class fluentd::params {
  # package params
  $package_ensure          = 'installed'
  $package_name            = 'td-agent'
  $package_install_options = []
  # service params
  $service_manage = true
  $service_name   = 'td-agent'
  $service_ensure = 'running'
  $service_enable = true
  # config params
  $config_path = '/etc/td-agent'
  $conf_dir    = "${config_path}/conf.d"
  $conf_dir_manage = false
  $config_file = "${config_path}/td-agent.conf"
  # user params
  $user_manage = true
  $user_name   = 'td-agent'
  $user_group  = 'td-agent'
  $user_groups = ['adm']

  case $::osfamily {
    'Debian': {
      $repo_manage = true
    }
    'Redhat': {
      $repo_manage = true
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily}")
    }
  }
}
