# Configure apt::source
#
class fluentd::repo::apt (
  $ensure       = 'present',
  $location     = downcase("http://packages.treasuredata.com/2/${::lsbdistid}/${::lsbdistcodename}"),
  $release      = $::lsbdistcodename,
  $repos        = 'contrib',
  $architecture = $::architecture,
  $key          = {
    'id'     => 'C901622B5EC4AF820C38AB861093DB45A12E206F',
    'source' => 'http://packages.treasuredata.com/GPG-KEY-td-agent'
  },
  $include      = {
    'src' => false,
    'deb' => true,
  },
) {

  include '::apt'

  apt::source { 'treasure-data':
    ensure       => $ensure,
    location     => $location,
    release      => $release,
    architecture => $architecture,
    repos        => $repos,
    key          => $key,
    include      => $include,
  }
}
