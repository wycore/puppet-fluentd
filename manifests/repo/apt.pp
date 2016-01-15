# Configure apt::source
#
class fluentd::repo::apt inherits fluentd {

  apt::source { $fluentd::repo_name:
    location      => $fluentd::repo_url,
    comment       => $fluentd::repo_desc,
    repos         => 'contrib',
    architecture  => 'amd64',
    release       => $fluentd::distro_codename,
    key           => {
      id      => $fluentd::repo_gpgkeyid,
      source  => $fluentd::repo_gpgkey,
    },
    include       => {
      'src'   => false,
      'deb'   => true,
    },
  }
}