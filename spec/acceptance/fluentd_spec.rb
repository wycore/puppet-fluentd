require 'spec_helper_acceptance'

RSpec.describe 'fluentd' do
  it 'runs successfully' do
    manifest = File.read(File.expand_path('../../examples/test.pp', File.dirname(__FILE__)))

    # Run it twice and test for idempotency
    apply_manifest(manifest, catch_failures: true)
    expect(apply_manifest(manifest, catch_failures: true).exit_code).to be_zero
  end

  # test package
  describe package('td-agent') do
    it { is_expected.to be_installed }
  end

  # test service
  describe service('td-agent') do
    it { is_expected.to be_running }
    # @todo
    # there seems to be a bug serverspec while checking if the service is enabled
    # on Debian 8:
    # server spec checks:
    # /bin/sh -c systemctl\ --quiet\ is-enabled\ td-agent
    # Failed to get unit file state for td-agent.service: No such file or directory
    #
    # but all update-rc.d files are present:
    # /etc/rc0.d/K01td-agent
    # /etc/rc1.d/K01td-agent
    # /etc/rc2.d/S01td-agent
    # /etc/rc3.d/S01td-agent
    # /etc/rc4.d/S01td-agent
    # /etc/rc5.d/S01td-agent
    # /etc/rc6.d/K01td-agent
    if ! ( os[:family] == 'debian' and os[:release].to_f >= 8.0 )
      it { is_expected.to be_enabled }
    end
  end

  # test gem installed plugin
  describe command('/opt/td-agent/embedded/bin/gem list') do
    its(:stdout) { should contain('fluent-plugin-elasticsearch') }
  end

end
