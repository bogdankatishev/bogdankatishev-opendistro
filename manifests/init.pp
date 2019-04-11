# Installs and configures Open Distro for ElasticSearch

class opendistro (
  Enum['present', 'absent'] $ensure                                                   = 'present',
  Optional[Enum['systemd', 'init', 'debian', 'redhat', 'upstart']] $service_provider  = undef,
  Boolean $manage_repo                                                                = true,
  Enum['enabled', 'running', 'disabled', 'unmanaged'] $service_ensure                 = 'enabled',
  String                         $java_package,
  String                         $package_name,
) {

  include opendistro::repo
  include opendistro::install
  include opendistro::config

  if $manage_repo {
    Class['opendistro::repo']
    ->Class['opendistro::install']
  }

  case $ensure {
    'present': {
      Class['opendistro::install']
      ->Class['opendistro::config']
    }
    default: {
      ->Class['opendistro::config']
      ->Class['opendistro::install']
    }
  }
}
