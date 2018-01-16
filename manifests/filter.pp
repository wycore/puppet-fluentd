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
  Enum['present', 'absent'] $ensure   = present,
  Integer                   $priority = 20,
  String                    $pattern  = '**',
  Hash                      $config   = {},
) {

  fluentd::config::file { "filter-${title}":
    ensure   => $ensure,
    priority => $priority,
    content  => template( 'fluentd/filter.erb'),
  }

}
