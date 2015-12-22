require 'spec_helper'

describe 'fluentd::user', :type => :class do
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
      should contain_user('fluentd').with({
        'name'   => 'td-agent',
        'gid'    => 'td-agent',
        'groups' => ['adm']
      })
    }
  end
end
