# opendistro::config
# @api private
#
# @summary It configures Open Distro for ElasticSearch
class opendistro::config (
String                         $service_name                = $opendistro::service_name,
String                         $java_tools_dir              = $opendistro::java_tools_dir,
) {

  file { '/usr/share/elasticsearch/lib/tools.jar':
    ensure => 'link',
    target => $java_tools_dir,
  }

  service { $service_name:
    ensure => 'running',
    enable => true,
  }

}

