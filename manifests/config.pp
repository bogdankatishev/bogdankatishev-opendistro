# opendistro::config
# @api private
#
# @summary It configures Open Distro for ElasticSearch
class opendistro::config (
String                         $service_name                = $opendistro::service_name,
) {

  file { '/usr/share/elasticsearch/lib/tools.jar':
    ensure => 'link',
    target => '/usr/lib/jvm/java-1.8.0/lib/tools.jar',
  }

  service { $service_name:
    ensure => 'running',
    enable => true,
  }

}

