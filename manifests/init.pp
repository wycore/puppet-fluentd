# Class: fluentd
# ===========================
#
# Installs and configures Fluentd.
#
# Parameters
# ----------
# [*repo_manage*]
#   Include repository to install recent fluentd (td-agent) from
#   Default: 'true'
# [*package_ensure*]
#   Package ensure
#   Default: 'installed'
# [*package_name*]
#   Package name
#   Default: 'td-agent'
# [*package_install_options*]
#   Package install options
#   Default: '[]'
# [*service_manage*]
#   Defines if the service should be managed by puppet
#   Default: 'true'
# [*service_name*]
#   Name of the service
#   Default: 'td-agent'
# [*service_ensure*]
#   Service ensure
#   Default: 'running'
# [*service_enable*]
#   Defines if the service should be enabled
#   Default: 'true'
# [*config_path*]
#   Path to configuration files
#   Default: '/etc/td-agent'
# [*config_dir*]
#   Configuration directory name
#   Default: '${config_path}/conf.d'
# [*config_file*]
#   Default configuration file name
#   Default: '${config_path}/td-agent.conf'
# [*conf_dir_manage*]
#   Exclusively handle config files into fluentd::conf_dir. Other files not created by puppet, will be deleted
#   Default: 'false'
# [*user_manage*]
#   Defines if the user should be manage, which will add the user
#   to groups defined in $user_groups.
#   For example to be able to view the /var/log directory with group adm
#   Default: 'true'
# [*user_name*]
#   Default: 'td-agent'
# [*user_group*]
#   Default: 'td-agent'
# [*user_groups*]
#   Default: '["adm"]'
#
# Examples
# --------
#
# @example
#    include '::fluentd'
#
# Copyright
# ---------
#
# Copyright 2015 wywy, unless otherwise noted.
#
class fluentd (
  Boolean                     $repo_manage             = $::fluentd::params::repo_manage,
  String                      $package_ensure          = $::fluentd::params::package_ensure,
  String                      $package_name            = $::fluentd::params::package_name,
  Array                       $package_install_options = $::fluentd::params::package_install_options,
  Boolean                     $service_manage          = $::fluentd::params::service_manage,
  String                      $service_name            = $::fluentd::params::service_name,
  Enum['running', 'stopped']  $service_ensure          = $::fluentd::params::service_ensure,
  Boolean                     $service_enable          = $::fluentd::params::service_enable,
  String                      $config_path             = $::fluentd::params::config_path,
  String                      $conf_dir                = $::fluentd::params::conf_dir,
  String                      $config_file             = $::fluentd::params::config_file,
  Boolean                     $conf_dir_manage         = $::fluentd::params::conf_dir_manage,
  Boolean                     $user_manage             = $::fluentd::params::user_manage,
  String                      $user_name               = $::fluentd::params::user_name,
  String                      $user_group              = $::fluentd::params::user_group,
  Array                       $user_groups             = $::fluentd::params::user_groups,
) inherits fluentd::params {

  # class calls
  include '::fluentd::repo'
  include '::fluentd::install'
  include '::fluentd::user'
  include '::fluentd::config'
  include '::fluentd::service'

  # dependencies
  Class['::Fluentd::Repo']
  -> Class['::Fluentd::Install']
  -> Class['::Fluentd::User']
  -> Class['::Fluentd::Config']
  -> Class['::Fluentd::Service']
}
