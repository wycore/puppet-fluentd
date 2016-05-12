require 'spec_helper'

describe 'fluentd::plugin' do
  let(:facts) {
    {
      :osfamily        => 'Debian',
      :lsbdistid       => 'Ubuntu',
      :operatingsystem => 'Ubuntu',
      :lsbdistcodename => 'precise',
      :architecture    => 'amd64',
    }
  }
  let(:pre_condition) { 'include fluentd' }

  context 'gem plugin' do
    let(:title) { 'fluent-plugin-elasticsearch' }
    let(:params) do
      {
          type: 'gem'
      }
    end

    it do
      should contain_package('fluent-plugin-elasticsearch').with({
        'ensure'   => 'present',
        'provider' => 'fluentd_gem',
        'notify'   => 'Class[Fluentd::Service]'
      })
    end
  end

  context 'file plugin' do
    let(:title) { 'fluent-plugin-test' }
    let(:params) do
      {
          type: 'file',
          source: 'puppet:///path/to/source'
      }
    end

    it do
      should contain_file('/etc/td-agent/plugin/fluent-plugin-test').with({
        'ensure' => 'present',
        'owner'  => 'td-agent',
        'group'  => 'td-agent',
        'mode'   => '0640',
        'source' => 'puppet:///path/to/source',
        'notify' => 'Class[Fluentd::Service]'
      })
    end
  end
end