require 'spec_helper'

describe 'fluentd::source' do
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

  context 'basic source' do
    let(:title) { 'test' }
    let(:params) do
      {
          priority: '10',
          config: {
            'type'   => 'tail',
            'format' => 'json',
            'path'   => '/var/log/test-application/*.json',
            'tag'    => 'application.test'
          }
      }
    end

    it do
      is_expected.to contain_file('/etc/td-agent/conf.d/10-source-test.conf').
        with_content(/<source>/).
        with_content(/type tail/).
        with_content(/format json/).
        with_content(/path \/var\/log\/test-application\/\*.json/).
        with_content(/tag application.test/).
        with_content(/<\/source>/)
    end
  end
end