require 'spec_helper'

describe 'fluentd::install', :type => :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      describe 'when called with no parameters' do
        it {
          should contain_package('fluentd').with({
            'ensure'          => 'installed',
            'name'            => 'td-agent',
            'install_options' => []
          })
        }
      end
    end
  end
end
