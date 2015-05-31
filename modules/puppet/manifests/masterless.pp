class puppet::masterless(
  $cron = true,
) {
  $offset = fqdn_rand(30)

  $_load_role = "::role::${::role}"
  if $::role and defined($_load_role) {
    include $_load_role
  }

  cron { 'puppet agent':
    ensure => absent,
  }

  if $cron {
    cron { 'puppet-apply':
      ensure  => present,
      user    => 'root',
      minute  => "${offset}",
      command => "/opt/puppet/script/puppet-apply"
    }
  }

  file { '/usr/bin/puprun':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => "/opt/puppet/script/puppet-apply",
  }
  file { '/opt/puppet/current_environment':
   ensure => file,
    content => "${::environment}\n",
  }
}
