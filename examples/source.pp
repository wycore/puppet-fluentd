# configure source
::fluentd::source { 'test':
  priority => 10,
  config   => {
    'type'   => 'tail',
    'format' => 'json',
    'path'   => '/var/log/test-application/*.json',
    'tag'    => 'application.test'
  }
}
