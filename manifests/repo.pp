# opendistro::repo
# @api private
#
# @summary It manages the package repositories to install Open Distro for ElasticSearch
class opendistro::repo {

  $download_url_OpenDistro = 'https://d3g5vo6xdbdb9a.cloudfront.net/yum/noarch/'
  $download_url_Elastic    = 'https://artifacts.elastic.co/packages/oss-6.x/yum'

  if ($opendistro::manage_repo == true) and ($opendistro::ensure == 'present') {
    case $facts['osfamily'] {
      'RedHat': {

        if !defined(Yumrepo['opendistroforelasticsearch-artifacts-repo']) {
          yumrepo{'opendistroforelasticsearch-artifacts-repo':
            ensure   => $opendistro::ensure,
            descr    => 'Release RPM artifacts of OpenDistroForElasticsearch',
            baseurl  => $download_url_OpenDistro,
            gpgcheck => 1,
            gpgkey   => 'https://d3g5vo6xdbdb9a.cloudfront.net/GPG-KEY-opendistroforelasticsearch',
            enabled  => 1,
          }
        }

        if !defined(Yumrepo['elastic']) {
          yumrepo{'elastic':
            ensure   => $opendistro::ensure,
            descr    => 'Elastic repository for 6.x packages',
            baseurl  => $download_url_Elastic,
            gpgcheck => 1,
            gpgkey   => 'https://d3g5vo6xdbdb9a.cloudfront.net/GPG-KEY-opendistroforelasticsearch',
            enabled  => 1,
          }
        }

      }
      'SuSe': {

        exec { 'topbeat_suse_import_gpg':
          command => '/usr/bin/rpmkeys --import https://d3g5vo6xdbdb9a.cloudfront.net/GPG-KEY-opendistroforelasticsearch',
          unless  => '/usr/bin/test $(rpm -qa gpg-pubkey | grep -i "D88E42B4" | wc -l) -eq 1 ',
          notify  => [ Zypprepo['opendistroforelasticsearch-artifacts-repo'] ],
        }
        if !defined (Zypprepo['opendistroforelasticsearch-artifacts-repo']) {
          zypprepo{'opendistroforelasticsearch-artifacts-repo':
            baseurl     => $download_url_OpenDistro,
            enabled     => 1,
            autorefresh => 1,
            name        => 'Release RPM artifacts of OpenDistroForElasticsearch',
            gpgcheck    => 1,
            gpgkey      => 'https://d3g5vo6xdbdb9a.cloudfront.net/GPG-KEY-opendistroforelasticsearch',
            type        => 'yum',
          }
        }

        exec { 'topbeat_suse_import_gpg':
          command => '/usr/bin/rpmkeys --import https://artifacts.elastic.co/GPG-KEY-elasticsearch',
          unless  => '/usr/bin/test $(rpm -qa gpg-pubkey | grep -i "D88E42B4" | wc -l) -eq 1 ',
          notify  => [ Zypprepo['elastic'] ],
        }
        if !defined (Zypprepo['elastic']) {
          zypprepo{'elastic':
            baseurl     => $download_url_Elastic,
            enabled     => 1,
            autorefresh => 1,
            name        => 'Elastic repository for 6.x packages',
            gpgcheck    => 1,
            gpgkey      => 'https://artifacts.elastic.co/GPG-KEY-elasticsearch',
            type        => 'yum',
          }
        }
      }
      default: {
      }
    }
  }
}
