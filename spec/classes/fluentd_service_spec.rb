require 'spec_helper'

describe 'fluentd::config', :type => :class do
  shared_examples 'when called with no parameters' do
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
