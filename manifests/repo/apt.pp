# Configure apt::source
#
class fluentd::repo::apt (
  $ensure   = 'present',
  $location = downcase("http://packages.treasuredata.com/2/${::operatingsystem}/${::lsbdistcodename}"),
  $release  = $::lsbdistcodename,
  $repos    = 'contrib',
  $key      = {
    'id'     => 'C901622B5EC4AF820C38AB861093DB45A12E206F',
    'source' => 'https://packages.treasuredata.com/GPG-KEY-td-agent'
  },
) {

  include '::apt'

  apt::source { 'treasure-data':
    ensure   => $ensure,
    location => $location,
    release  => $release,
    repos    => $repos,
    key      => $key,
  }
}
