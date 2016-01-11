require 'beaker-rspec'
require 'pry'

hosts.each do |host|
  # Install Puppet
  on host, 'apt-get -y install ruby1.9.1 rubygems ruby1.9.1-dev libaugeas-ruby1.9.1'
  on host, 'update-alternatives --set ruby /usr/bin/ruby1.9.1'
  on host, 'update-alternatives --set gem /usr/bin/gem1.9.1'
  on host, install_puppet
end

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
      on host, puppet('module', 'install', 'puppetlabs-stdlib', '--version', '4.9.0')
      on host, puppet('module', 'install', 'puppetlabs-apt', '--version', '2.1.1')
    end
  end
end
