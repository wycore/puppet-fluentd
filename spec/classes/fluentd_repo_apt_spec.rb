require 'spec_helper'

describe 'fluentd::repo::apt', :type => :class do
  let(:facts) {
    {
      :osfamily        => 'Debian',
      :lsbdistid       => 'Ubuntu',
      :operatingsystem => 'Ubuntu',
      :lsbdistcodename => 'precise',
      :architecture    => 'amd64',
    }
  }

  describe 'when called with no parameters on Ubuntu' do
    it {
      should contain_class('apt')
      should contain_apt__source('treasure-data').with({
        'ensure'       => 'present',
        'location'     => 'http://packages.treasuredata.com/2/ubuntu/precise',
        'release'      => 'precise',
        'repos'        => 'contrib',
        'architecture' => 'amd64',
        'key'          => {
          'id'     => 'BEE682289B2217F45AF4CC3F901F9177AB97ACBE',
          'source' => 'http://packages.treasuredata.com/GPG-KEY-td-agent'
        },
        'include'      => {
          'src' => false,
          'deb' => true
        }
      })
    }
  end
end
