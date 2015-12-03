require 'spec_helper'

describe 'fluentd::config', :type => :class do
  let(:facts) {
    {
      :osfamily        => 'Debian',
      :lsbdistid       => 'Ubuntu',
      :operatingsystem => 'Ubuntu',
      :lsbdistcodename => 'precise',
    }
  }

  describe 'when called with no parameters on Ubuntu' do
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
