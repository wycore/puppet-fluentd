# configure match
::fluentd::match { 'test':
  priority => 30,
  pattern  => '*.test',
  config   => {
    'flush_interval' => '30s',
    'type'           => 'secure_forward',
    'secure'         => 'yes',
    'shared_key'     => 'my_shared_key',
    'self_hostname'  => 'instance.test.com',
    'ca_cert_path'   => '/path/to/ca.cert',
    'server'         => [{
      'host' => 'test.server.com',
    }]
  }
}

::fluentd::match { 'test':
  priority => 30,
  pattern  => '*.test',
  config   => {
    'type'  => 'copy',
    'store' => [{
      'type'           => 'elasticsearch',
      'logstashformat' => true,
      'hosts'          => '172.20.10.17:9200',
      'flush_interval' => '30s',
      },
      {
      'type' => 'file',
      'path' => '/tmp/td-agent-debug.log',
      }
    ]
  }
}
