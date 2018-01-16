source 'https://rubygems.org'

ENV['PUPPET_VERSION'].nil? ? puppetversion = '~> 4.0' : puppetversion = ENV['PUPPET_VERSION'].to_s
gem 'puppet', puppetversion
gem 'puppetlabs_spec_helper', '>= 0.8.2'
gem 'puppet-lint', '>= 1.0.0'
gem 'facter', '>= 1.7.0'
gem 'beaker-puppet_install_helper'
gem 'metadata-json-lint'
gem 'rspec-puppet-facts', '~> 1.7'

beakerrspec = '> 0'
platforms [:ruby_19, :ruby_21] do
  beakerrspec = '<= 5.6.0'
end
gem 'beaker-rspec', beakerrspec

platforms :ruby_19 do
  gem 'public_suffix', '< 1.5.0', :platforms => :ruby_19
  gem 'nokogiri', '~> 1.8.1', :platforms => :ruby_19
  gem 'mime-types', '< 3.0', :platforms => :ruby_19
end
