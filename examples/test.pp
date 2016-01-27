# This file is use for the beaker tests.

# basic installation
include '::fluentd'

# install a gem plugin
::fluentd::plugin { 'fluent-plugin-elasticsearch':
  type    => 'gem',
  require => Class['::fluentd']
}
