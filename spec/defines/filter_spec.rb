require 'spec_helper'

describe 'fluentd::filter' do
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

  context 'basic filter' do
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
