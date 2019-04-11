# auditbeat::install
# @api private
#
# @summary It installs the Open Distro for ElasticSearch package
class opendistro::install (
  String                         $java_package                = $opendistro::java_package,
  String                         $package_name                = $opendistro::package_name,
) {

  case $opendistro::ensure {
    'present': {
      $package_ensure = $opendistro::package_ensure
    }
    default: {
      $package_ensure = $opendistro::ensure
    }
  }

  ##########
  ## JAVA ##
  ##########

  if ! defined (Package[$java_package]) {
    package { $java_package:
      ensure => 'installed';
    }
  }

  #############
  ## PACKAGE ##
  #############

  package{$package_name:
    ensure => $package_ensure,
  }

}
