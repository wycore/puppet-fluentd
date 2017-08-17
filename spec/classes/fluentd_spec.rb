require 'spec_helper'

describe 'fluentd', :type => :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      describe 'when called with no parameters' do
        it {
          should contain_class('fluentd::repo')
          should contain_class('fluentd::install')
          should contain_class('fluentd::config')
          should contain_class('fluentd::service')
        }
      end
    end
  end
end
