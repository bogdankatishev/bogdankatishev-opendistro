# auditbeat::install
# @api private
#
# @summary It installs the Open Distro for ElasticSearch package
class opendistro::install {
  case $opendistro::ensure {
    'present': {
      $package_ensure = $opendistro::package_ensure
    }
    default: {
      $package_ensure = $opendistro::ensure
    }
  }

  package{'opendistroforelasticsearch':
    ensure => $package_ensure,
  }

  package{'java-1.8.0-openjdk-devel':
    ensure => 'installed',
  }

}
