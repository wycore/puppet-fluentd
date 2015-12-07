# configure filter
::fluentd::filter { 'test':
  priority => 20,
  pattern  => '*.test',
  config   => {
    'type'   => 'record_transformer',
    'record' => {
      'hostname' => '${hostname}'
    }
  }
}
