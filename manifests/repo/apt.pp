# Configure apt::source
#
class fluentd::repo::apt (
  $ensure       = 'present',
  $location     = downcase("http://packages.treasuredata.com/3/${::lsbdistid}/${::lsbdistcodename}"),
  $release      = $::lsbdistcodename,
  $repos        = 'contrib',
  $architecture = $::architecture,
  $key          = {
    'id'     => 'BEE682289B2217F45AF4CC3F901F9177AB97ACBE',
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
