require 'spec_helper'

describe 'fluentd::repo::apt', :type => :class do
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
      should contain_class('apt')
      should contain_apt__source('treasure-data').with({
        'ensure'   => 'present',
        'location' => 'http://packages.treasuredata.com/2/ubuntu/precise',
        'release'  => 'precise',
        'repos'    => 'contrib',
        'key'      => {
          'id'     => 'C901622B5EC4AF820C38AB861093DB45A12E206F',
          'source' => 'https://packages.treasuredata.com/GPG-KEY-td-agent'
        }
      })
    }
  end
end
