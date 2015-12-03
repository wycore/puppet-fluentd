require 'spec_helper'

describe 'fluentd', :type => :class do
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
      should contain_class('fluentd::repo')
      should contain_class('fluentd::install')
      should contain_class('fluentd::config')
      should contain_class('fluentd::service')
    }
  end
end
