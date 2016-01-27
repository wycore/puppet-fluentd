require 'spec_helper'

describe 'fluentd::repo::yum', :type => :class do
  let(:facts) {
    {
      :osfamily => 'RedHat',
    }
  }

  describe 'when called with no parameters on RedHat' do
    it {
      should contain_yumrepo('treasure-data').with({
        'ensure'   => 'present',
        'baseurl'  => 'https://packages.treasuredata.com/2/redhat/$releasever/$basearch',
        'descr'    => 'TreasureData',
        'enabled'  => '1',
        'gpgcheck' => '1'
      }).that_notifies('Exec[add GPG key]')

      should contain_exec('add GPG key').with({
        'command'     => 'rpm --import https://packages.treasuredata.com/GPG-KEY-td-agent',
        'path'        => '/bin:/usr/bin/',
        'refreshonly' => 'true'
      })
    }
  end
end
