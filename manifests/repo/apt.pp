# Configure apt::source
#
class fluentd::repo::apt (
  $ensure      = 'present',
  $location    = downcase("http://packages.treasuredata.com/2/${::operatingsystem}/${::lsbdistcodename}"),
  $release     = $::lsbdistcodename,
  $repos       = 'contrib',
  $key_source  = 'https://packages.treasuredata.com/GPG-KEY-td-agent',
) {

  include '::apt'

  apt::source { 'treasure-data':
    ensure     => $ensure,
    location   => $location,
    release    => $release,
    repos      => $repos,
    key_source => $key_source,
  }
}