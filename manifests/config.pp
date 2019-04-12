# opendistro::config
# @api private
#
# @summary It configures Open Distro for ElasticSearch
class opendistro::config (
String                                  $service_name                = $opendistro::service_name,
Optional[String]                        $java_tools_dir              = $opendistro::java_tools_dir,
) {

  #############################
  ## SYMLINK ONLY FOR JAVA 8 ##
  #############################

  if $opendistro::java_package =~ /^java-1.8/ {
    file { '/usr/share/elasticsearch/lib/tools.jar':
      ensure => 'link',
      target => $java_tools_dir,
    }
  }

  ################
  ## ES SERVICE ##
  ################

  service { $service_name:
    ensure => 'running',
    enable => true,
  }

}

