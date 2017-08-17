require 'spec_helper'

describe 'fluentd::config', :type => :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      describe 'when called with no parameters' do
        it {
          should contain_service('fluentd').with({
            'name'       => 'td-agent',
            'ensure'     => 'running',
            'enable'     => 'true',
            'hasstatus'  => 'true',
            'hasrestart' => 'true'
          })
        }
      end
    end
  end
end
