# Class: fluentd
# ===========================
#
# Full description of class fluentd here.
#
# Parameters
# ----------
# [*ensure*]
#   Default: 'present'
# [*manage_repo*]
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
# [*service_enabled*]
#   Defines if the service should be enabled, defaults to 'true'
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
# Copyright 2015 wywy GmbH, unless otherwise noted.
#
class fluentd (
  $ensure                  = $::fluentd::params::ensure,
  $manage_repo             = $::fluentd::params::manage_repo,
  $package_ensure          = $::fluentd::params::package_ensure,
  $package_name            = $::fluentd::params::package_name,
  $package_install_options = $::fluentd::params::package_install_options,
  $service_manage          = $::fluentd::params::service_manage,
  $service_name            = $::fluentd::params::service_name,
  $service_ensure          = $::fluentd::params::service_ensure,
  $service_enable          = $::fluentd::params::service_enable,
) inherits fluentd::params {

  # parameter validation
  validate_string($ensure)
  validate_bool($manage_repo)
  validate_string($package_ensure)
  validate_string($package_name)
  validate_array($package_install_options)
  validate_bool($service_manage)
  validate_string($service_name)
  validate_bool($service_enable)
  if ! ($service_ensure in [ 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }

  # class calls
  include '::fluentd::repo'
  include '::fluentd::install'
  include '::fluentd::config'
  include '::fluentd::service'

  # dependencies
  Class['::Fluentd::Repo']    ->
  Class['::Fluentd::Install'] ->
  Class['::Fluentd::Config']  ->
  Class['::Fluentd::Service']

}
