# gem installation
::fluentd::plugin { 'fluent-plugin-elasticsearch':
  type => 'gem'
}
# file installation
::fluentd::plugin { 'fluent-plugin-elasticsearch':
  type   => 'file',
  source => 'puppet://path/to/plugin'
}
