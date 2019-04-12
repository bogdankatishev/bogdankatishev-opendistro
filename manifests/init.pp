# Installs and configures Open Distro for ElasticSearch

class opendistro (
  String                         $java_package,
  String                         $package_name,
  String                         $package_ensure                                      = 'installed',
  String                         $service_name                                        = 'elasticsearch',
  Enum['present', 'absent'] $ensure                                                   = 'present',
  Boolean $manage_repo                                                                = true,
  Enum['enabled', 'running', 'disabled', 'unmanaged'] $service_ensure                 = 'enabled',
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
      Class['opendistro::config']
      ->Class['opendistro::install']
    }
  }
}
