# opendistro::repo
# @api private
#
# @summary It manages the package repositories to install Open Distro for ElasticSearch
class opendistro::repo {
  if ($opendistro::manage_repo == true) and ($opendistro::ensure == 'present') {
    case $facts['osfamily'] {
      'RedHat': {

        $download_url = 'https://d3g5vo6xdbdb9a.cloudfront.net/yum/noarch/'

        if !defined(Yumrepo['opendistroforelasticsearch-artifacts-repo']) {
          yumrepo{'':
            ensure   => $opendistro::ensure,
            descr    => 'Release RPM artifacts of OpenDistroForElasticsearch',
            baseurl  => $download_url,
            gpgcheck => 1,
            gpgkey   => 'https://d3g5vo6xdbdb9a.cloudfront.net/GPG-KEY-opendistroforelasticsearch',
            enabled  => 1,
          }
        }
      }
      'SuSe': {

        $download_url = 'https://d3g5vo6xdbdb9a.cloudfront.net/yum/noarch/'

        exec { 'topbeat_suse_import_gpg':
          command => '/usr/bin/rpmkeys --import https://d3g5vo6xdbdb9a.cloudfront.net/GPG-KEY-opendistroforelasticsearch',
          unless  => '/usr/bin/test $(rpm -qa gpg-pubkey | grep -i "D88E42B4" | wc -l) -eq 1 ',
          notify  => [ Zypprepo['opendistroforelasticsearch-artifacts-repo'] ],
        }
        if !defined (Zypprepo['opendistroforelasticsearch-artifacts-repo']) {
          zypprepo{'opendistroforelasticsearch-artifacts-repo':
            baseurl     => $download_url,
            enabled     => 1,
            autorefresh => 1,
            name        => 'opendistroforelasticsearch-artifacts-repo',
            gpgcheck    => 1,
            gpgkey      => 'https://d3g5vo6xdbdb9a.cloudfront.net/GPG-KEY-opendistroforelasticsearch',
            type        => 'yum',
          }
        }
      }
      default: {
      }
    }
  }
}
