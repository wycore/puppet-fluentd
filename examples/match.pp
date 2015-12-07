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
    'servers'        => {
      'host' => 'test.server.com'
    }
  }
}
