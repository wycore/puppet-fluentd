# Configure yumrepo
#
class fluentd::repo::yum (
  $descr    = 'TreasureData',
  $baseurl  = 'https://packages.treasuredata.com/2/redhat/$releasever/$basearch',
  $enabled  = '1',
  $gpgcheck = '1',
  $gpgkey   = 'https://packages.treasuredata.com/GPG-KEY-td-agent',
) {

  yumrepo { 'treasure-data':
    descr    => $descr,
    baseurl  => $baseurl,
    enabled  => $enabled,
    gpgcheck => $gpgcheck,
    notify   => Exec['add GPG key'],
  }

  exec { 'add GPG key':
    command     => "/usr/bin/rpm --import ${fluentd::repo::yum::gpgkey}",
    refreshonly => true,
  }
}
