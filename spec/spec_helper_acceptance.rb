require 'beaker-rspec'
require 'beaker/puppet_install_helper'

run_puppet_install_helper unless ENV['BEAKER_provision'] == 'no'

RSpec.configure do |c|
  # Project root
  module_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module
    puppet_module_install(:source => module_root, :module_name => 'fluentd')
    hosts.each do |host|
      on host, puppet('module', 'install', 'puppetlabs-stdlib', '--version', '4.6.0')
      on host, puppet('module', 'install', 'puppetlabs-apt', '--version', '2.0.0')
    end
  end
end
