require 'spec_helper'

describe 'fluentd::repo::apt', :type => :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      case facts[:osfamily]
      when 'Debian'
        it {
          should contain_class('apt')
          should contain_apt__source('treasure-data').with({
            'ensure'       => 'present',
            'repos'        => 'contrib',
            'architecture' => 'amd64',
            'key'          => {
                'id'     => 'BEE682289B2217F45AF4CC3F901F9177AB97ACBE',
                'source' => 'http://packages.treasuredata.com/GPG-KEY-td-agent'
            },
            'include'      => {
                'src' => false,
                'deb' => true
            }
          })
        }
        case facts[:operatingsystem]
        when 'Ubuntu'
          case facts[:lsbdistcodename]
          when 'boinic'
            it {
              should contain_apt__source('treasure-data').with({
                'location'     => 'http://packages.treasuredata.com/3/ubuntu/bionic',
                'release'      => 'boinic'
              })
            }
          when 'precise'
            it {
              should contain_apt__source('treasure-data').with({
                'location'     => 'http://packages.treasuredata.com/3/ubuntu/precise',
                'release'      => 'precise'
              })
            }
          when 'trusty'
            it {
              should contain_apt__source('treasure-data').with({
                'location'     => 'http://packages.treasuredata.com/3/ubuntu/trusty',
                'release'      => 'trusty'
              })
            }
          when 'xenial'
            it {
              should contain_apt__source('treasure-data').with({
                'location'     => 'http://packages.treasuredata.com/3/ubuntu/xenial',
                'release'      => 'xenial'
              })
            }
          end
        when 'Debian'
          case facts[:lsbdistcodename]
          when 'stretch'
            it {
              should contain_apt__source('treasure-data').with({
                'location'     => 'http://packages.treasuredata.com/3/debian/stretch',
                'release'      => 'stretch'
              })
          }
          when 'jessie'
            it {
              should contain_apt__source('treasure-data').with({
                'location'     => 'http://packages.treasuredata.com/3/debian/jessie',
                'release'      => 'jessie'
              })
          }
          when 'squeeze'
            it {
              should contain_apt__source('treasure-data').with({
                'location'     => 'http://packages.treasuredata.com/3/debian/squeeze',
                'release'      => 'squeeze'
              })
            }
          when 'wheezy'
            it {
              should contain_apt__source('treasure-data').with({
                'location'     => 'http://packages.treasuredata.com/3/debian/wheezy',
                'release'      => 'wheezy'
              })
            }
          end
        end
      end
    end
  end
end
