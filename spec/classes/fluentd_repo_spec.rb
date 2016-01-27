require 'spec_helper'

describe 'fluentd::repo', :type => :class do

  context 'when called with no parameters on osfamily Debian' do
    let(:facts) {
      {
        :osfamily        => 'Debian',
        :lsbdistid       => 'Ubuntu',
        :operatingsystem => 'Ubuntu',
        :lsbdistcodename => 'precise',
      }
    }
    it {
      should contain_class('fluentd::repo::apt')
    }
  end

  context 'when called with no parameters on osfamily RedHat' do
    let(:facts) {
      {
        :osfamily => 'RedHat',
      }
    }
    it {
      should contain_class('fluentd::repo::yum')
    }
  end
end
