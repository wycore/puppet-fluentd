require 'spec_helper'

describe 'fluentd::match' do
  let(:facts) {
    {
      :osfamily        => 'Debian',
      :lsbdistid       => 'Ubuntu',
      :operatingsystem => 'Ubuntu',
      :lsbdistcodename => 'precise',
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
              'servers'        => {
                'host' => 'test.server.com'
              }
          }
      }
    end

    it do
      is_expected.to contain_file('/etc/td-agent/conf.d/30-match-test.conf').
        with_content(/<match \*.test>/).
        with_content(/flush_interval 30s/).
        with_content(/type secure_forward/).
        with_content(/secure yes/).
        with_content(/shared_key my_shared_key/).
        with_content(/self_hostname instance.test.com/).
        with_content(/ca_cert_path \/path\/to\/ca.cert/).
        with_content(/<servers>/).
        with_content(/host test.server.com/).
        with_content(/<\/servers>/).
        with_content(/<\/match>/)
    end
  end
end