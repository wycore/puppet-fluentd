require 'spec_helper'

describe 'fluentd', :type => :class do
  shared_examples 'when called with no parameters' do
    it {
      should contain_class('fluentd::repo')
      should contain_class('fluentd::install')
      should contain_class('fluentd::config')
      should contain_class('fluentd::service')
    }
  end

  context 'when osfamily is Debian' do
    let(:facts) {
      {
        :osfamily        => 'Debian',
        :lsbdistid       => 'Ubuntu',
        :operatingsystem => 'Ubuntu',
        :lsbdistcodename => 'precise',
        :architecture    => 'amd64',
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
