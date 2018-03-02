# configure source
::fluentd::source { 'test':
  priority => 10,
  config   => {
    'type'   => 'tail',
    'format' => 'json',
    'path'   => '/var/log/test-application/*.json',
    'parse'  => {
      'type'       => 'regexp',
      'expression' => '^(?<name>[^ ]*) (?<user>[^ ]*) (?<age>\d*)$'
    },
    'storage'=> {
      'type'   => 'local',
      'path'   => 'test.pos'
    },
    'tag'    => 'application.test'
  }
}
