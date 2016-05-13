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
        with_content(/<filter \*.test>/).
        with_content(/type record_transformer/).
        with_content(/<record>/).
        with_content(/hostname \$\{hostname\}/).
        with_content(/<\/record>/).
        with_content(/<\/filter>/)
    end
  end
end