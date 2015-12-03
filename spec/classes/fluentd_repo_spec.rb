require 'spec_helper'

describe 'fluentd::repo', :type => :class do
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
      should contain_class('fluentd::repo::apt')
    }
  end
end
