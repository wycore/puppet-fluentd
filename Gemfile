source 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? "#{ENV['PUPPET_VERSION']}" : ['>= 3.3']
gem 'puppet', puppetversion
gem 'puppetlabs_spec_helper', '>= 0.8.2'
gem 'puppet-lint', '>= 1.0.0'
gem 'facter', '>= 1.7.0'
gem 'beaker-puppet_install_helper'
gem 'metadata-json-lint'

beakerrspec = '> 0'
platforms [:ruby_19, :ruby_21] do
  beakerrspec = '<= 5.6.0'
end
gem 'beaker-rspec', beakerrspec

platforms :ruby_19 do
  gem 'public_suffix', '< 1.5.0', :platforms => :ruby_19
  gem 'nokogiri', '< 1.7.0', :platforms => :ruby_19
  gem 'mime-types', '< 3.0', :platforms => :ruby_19
end