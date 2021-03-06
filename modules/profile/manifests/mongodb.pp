class profile::mongodb {
  include ::profile::docker
  $_version = hiera('mongodb::version', '2.4.14')

  if $::osfamily == 'Debian' {
    # Needed to build mongoengine
    package { 'mongodb-dev':
      ensure => present
    }
  }

  docker::image { 'mongo':
    ensure    => present,
    image_tag => $_version,
    notify    => Exec['create mongodb data container'],
  }

  exec { 'create mongodb data container':
    command     => 'docker create -v /data --name mongodata mongo /bin/true',
    path        => [
      '/bin',
      '/sbin',
      '/usr/bin',
      '/usr/sbin',
    ],
    refreshonly => true,
    require     => Docker::Image['mongo']
  }

  docker::run { 'mongo':
    image   => 'mongo',
    volumes_from => [
      'mongodata',
    ],
    ports   => [
      '127.0.0.1:27017:27017',
    ],
    require => [
      Docker::Image['mongo'],
      Exec['create mongodb data container'],
    ],
  }
}
