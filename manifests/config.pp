# opendistro::config
# @api private
#
# @summary It configures Open Distro for ElasticSearch
class opendistro::config {

  service { 'elasticsearch':
    enable => true,
  }

}

