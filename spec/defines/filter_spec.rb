require 'spec_helper'

describe 'fluentd::filter' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      let(:pre_condition) { 'include fluentd' }

      describe 'basic filter' do
        let(:title) { 'test' }
        let(:params) do
          {
            priority: '20',
            pattern: '*.test',
            config: {
              'type'   => 'record_transformer',
              'record' => {
                'hostname' => '${hostname}'
              }
            }
          }
        end

        it do
          is_expected.to contain_file('/etc/td-agent/conf.d/20-filter-test.conf').
          with_content(IO.read(File.join(File.dirname(__FILE__), '../fixtures/files/filter_record_transformer.conf')))
        end
      end
    end
  end
end
