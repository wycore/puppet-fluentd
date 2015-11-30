# Configure package
#
class fluentd::install inherits fluentd {

  package { 'fluentd':
    ensure          => $package_ensure,
    name            => $package_name,
    install_options => $package_install_options,
  }

}
