require 'spec_helper'

describe 'fluentd::install', :type => :class do
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
      should contain_package('fluentd').with({
        'ensure'          => 'installed',
        'name'            => 'td-agent',
        'install_options' => []
      })
    }
  end
end
