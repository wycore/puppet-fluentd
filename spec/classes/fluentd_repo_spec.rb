require 'spec_helper'

describe 'fluentd::repo', :type => :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      describe 'when called with no parameters' do
        case facts[:osfamily]
        when 'Debian'
          it { is_expected.to contain_class('fluentd::repo::apt') }
        when 'RedHat'
          it { is_expected.to contain_class('fluentd::repo::yum') }
        end
      end
    end
  end
end

