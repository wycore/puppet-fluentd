# Class: fluentd
# ===========================
#
# Full description of class fluentd here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'fluentd':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class fluentd (
  $ensure                  = $::fluentd::params::ensure,
  $manage_repo             = $::fluentd::params::manage_repo,
  $package_ensure          = $::fluentd::params::package_ensure,
  $package_name            = $::fluentd::params::package_name,
  $package_install_options = $::fluentd::params::package_install_options,
) inherits fluentd::params {

  validate_string($ensure)
  validate_bool($manage_repo)
  validate_string($package_ensure)
  validate_string($package_name)
  validate_array($package_install_options)

  if $manage_repo {
    class { '::fluentd::repo': }
  }

  class { '::fluentd::install': } ->
  class { '::fluentd::config':  }

}
