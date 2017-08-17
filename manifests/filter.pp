# Define: fluentd::filter
# ===========================
#
# Configures a 'filter' config file.
#
# Parameters
# ----------
# [*ensure*]
#   Default: 'present'
# [*priority*]
#   Defines the priority
#   Default: '20'
# [*pattern*]
#   Defines matching the pattern
#   Default: '**'
# [*config*]
#   Configuration, which must be a hash
#   Default: {}'
#
# Examples
# --------
#
# @example
#    ::fluentd::filter { 'test':
#      priority => 20,
#      pattern  => '*.test',
#      config   => {
#        'type'   => 'record_transformer',
#        'record' => {
#          'hostname' => '${hostname}'
#        }
#      }
#    }
#
# Copyright
# ---------
#
# Copyright 2015 wywy, unless otherwise noted.
#
define fluentd::filter (
  $ensure   = present,
  $priority = 20,
  $pattern  = '**',
  $config   = {},
) {

  # parameter validation
  if ! ($ensure in [ 'present', 'absent' ]) {
    fail('ensure parameter must be present or absent')
  }
  validate_integer($priority)
  validate_string($pattern)
  validate_hash($config)

  fluentd::config::file { "filter-${title}":
    ensure   => $ensure,
    priority => $priority,
    content  => template( 'fluentd/filter.erb'),
  }
}
