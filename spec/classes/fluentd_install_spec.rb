require 'spec_helper'

describe 'fluentd::install', :type => :class do

  shared_examples 'when called with no parameters' do
    it {
      should contain_package('fluentd').with({
        'ensure'          => 'installed',
        'name'            => 'td-agent',
        'install_options' => []
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
