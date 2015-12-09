# Define: fluentd::plugin
# ===========================
#
# Installs a plugin for fluentd.
#
# Parameters
# ----------
# [*ensure*]
#   Default: 'present'
# [*type*]
#   Which type of plugin, allowed values are gem and file
#   Default: 'gem'
# [*source*]
#   source to file for the plugin only needed if you use type: file
#   Default: 'undef'
#
# Examples
# --------
#
# @example
#    ::fluentd::plugin { 'fluent-plugin-elasticsearch': }
#
# Copyright
# ---------
#
# Copyright 2015 wywy GmbH, unless otherwise noted.
#
define fluentd::plugin (
  $ensure = present,
  $type   = 'gem',
  $source = undef,
) {

  # parameter validation
  if ! ($ensure in [ 'present', 'absent' ]) {
    fail('ensure parameter must be present or absent')
  }

  case $type {
    'gem': {
      fluentd::plugin::gem { $name:
        ensure  => $ensure,
        require => Class['Fluentd::Install'],
      }
    }
    'file': {
      validate_string($source)

      fluentd::plugin::file { $name:
        ensure  => $ensure,
        source  => $source,
        require => Class['Fluentd::Install'],
      }
    }
    default: {
      fail("plugin type: '${type}' is currently not supported, use gem or file")
    }
  }
}
