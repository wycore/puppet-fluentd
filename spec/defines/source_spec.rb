require 'spec_helper'

describe 'fluentd::source' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      let(:pre_condition) { 'include fluentd' }

      describe 'basic source' do
        let(:title) { 'test' }
        let(:params) do
          {
              priority: 10,
              config: {
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
        end

        it do
          is_expected.to contain_file('/etc/td-agent/conf.d/10-source-test.conf').
              with_content(IO.read(File.join(File.dirname(__FILE__), '../fixtures/files/source_tail.conf')))
        end
      end
    end
  end
end
