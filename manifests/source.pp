# Define: fluentd::source
# ===========================
#
# Configures a 'source' config file.
#
# Parameters
# ----------
# [*ensure*]
#   Default: 'present'
# [*priority*]
#   Defines the priority
#   Default: '10'
# [*config*]
#   Configuration, which must be a hash
#   Default: {}'
#
# Examples
# --------
#
# @example
#    ::fluentd::source { 'test':
#      priority => 10,
#      config   => {
#        'type'   => 'tail',
#        'format' => 'json',
#        'path'   => '/var/log/test-application/*.json',
#        'tag'    => 'application.test'
#      }
#    }
#
# Copyright
# ---------
#
# Copyright 2015 wywy, unless otherwise noted.
#
define fluentd::source (
  $ensure   = present,
  $priority = 10,
  $config   = {},
) {

  # parameter validation
  if ! ($ensure in [ 'present', 'absent' ]) {
    fail('ensure parameter must be present or absent')
  }
  validate_integer($priority)
  validate_hash($config)

  fluentd::config::file { "source-${title}":
    ensure   => $ensure,
    priority => $priority,
    content  => template( 'fluentd/source.erb'),
  }
}
