require 'spec_helper'

describe 'fluentd::match' do
  let(:facts) {
    {
      :osfamily        => 'Debian',
      :lsbdistid       => 'Ubuntu',
      :operatingsystem => 'Ubuntu',
      :lsbdistcodename => 'precise',
      :architecture    => 'amd64',
    }
  }
  let(:pre_condition) { 'include fluentd' }

  context 'basic match' do
    let(:title) { 'test' }
    let(:params) do
      {
          priority: '30',
          pattern: '*.test',
          config: {
              'flush_interval' => '30s',
              'type'           => 'secure_forward',
              'secure'         => 'yes',
              'shared_key'     => 'my_shared_key',
              'self_hostname'  => 'instance.test.com',
              'ca_cert_path'   => '/path/to/ca.cert',
              'server'         => [
                  {
                    'host' => 'test.server.com',
                  }
              ]
          }
      }
    end

    it do
      is_expected.to contain_file('/etc/td-agent/conf.d/30-match-test.conf').
          with_content(IO.read(File.join(File.dirname(__FILE__), '../fixtures/files/match_secure_forward.conf')))
    end
  end

  context 'multiple store' do
    let(:title) { 'test' }
    let(:params) do
      {
          priority: '30',
          pattern: '*.test',
          config: {
              'type'  => 'copy',
              'store' => [
                  {
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
    end

    it do
      is_expected.to contain_file('/etc/td-agent/conf.d/30-match-test.conf').
          with_content(IO.read(File.join(File.dirname(__FILE__), '../fixtures/files/match_copy.conf')))
    end
  end
end
