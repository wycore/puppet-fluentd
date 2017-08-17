require 'spec_helper'

describe 'fluentd::user', :type => :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      describe 'when called with no parameters' do
        it {
          should contain_user('fluentd').with({
            'name'   => 'td-agent',
            'gid'    => 'td-agent',
            'groups' => ['adm']
          })
        }
      end
    end
  end
end
