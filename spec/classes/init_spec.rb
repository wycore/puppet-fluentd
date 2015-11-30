require 'spec_helper'
describe 'fluentd' do

  context 'with defaults for all parameters' do
    it { should contain_class('fluentd') }
  end
end
