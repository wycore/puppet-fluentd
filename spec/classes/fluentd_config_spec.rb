require 'spec_helper'

describe 'fluentd::config', :type => :class do
  shared_examples 'when called with no parameters' do
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

  context 'when osfamily is Debian' do
    let(:facts) {
      {
        :osfamily        => 'Debian',
        :lsbdistid       => 'Ubuntu',
        :operatingsystem => 'Ubuntu',
        :lsbdistcodename => 'precise',
      }
    }

    include_examples 'when called with no parameters'
  end

  context 'when osfamily is RedHat' do
    let(:facts) {
      {
        :osfamily => 'RedHat',
      }
    }

    include_examples 'when called with no parameters'
  end
end
