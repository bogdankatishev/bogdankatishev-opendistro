# Installs and configures Open Distro for ElasticSearch

class opendistro (
  Enum['present', 'absent'] $ensure                                                   = 'present',
) {

  include opendistro::repo
  include opendistro::install
  include opendistro::config
  include opendistro::service

  if $manage_repo {
    Class['opendistro::repo']
    ->Class['opendistro::install']
  }

  case $ensure {
    'present': {
      Class['opendistro::install']
      ->Class['opendistro::config']
      ~>Class['opendistro::service']
    }
    default: {
      Class['opendistro::service']
      ->Class['opendistro::config']
      ->Class['opendistro::install']
    }
  }
}
