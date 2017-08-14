require 'spec_helper'

describe 'fluentd::config', :type => :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      describe 'when called with no parameters' do

        it {
          should contain_file('/etc/td-agent/td-agent.conf').with({
            'ensure' => 'file',
            'owner'  => 'root',
            'group'  => 'root',
            'source' => 'puppet:///modules/fluentd/td-agent.conf',
            'notify' => 'Class[Fluentd::Service]'
          })

          should contain_file('/etc/td-agent/conf.d').with({
            'ensure' => 'directory',
            'owner'  => 'td-agent',
            'group'  => 'td-agent',
            'mode'   => '0750'
          })
        }
      end
    end
  end
end
