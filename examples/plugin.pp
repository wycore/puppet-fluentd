# gem installation
::fluentd::plugin { 'fluent-plugin-elasticsearch':
  type => 'gem'
}
# file installation
::fluentd::plugin { 'fluent-plugin-elasticsearch':
  type   => 'file',
  source => 'puppet:///modules/path/to/plugin'
}
