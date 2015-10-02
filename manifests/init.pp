# IPnett BaaS puppet module
class ipnett_baas (

  $enable_repo       = true,
  $enable_enroll     = true,

)
{
  package { 'ipnett-baas':
      ensure => 'latest';
  }

  file {
    '/opt/tivoli/tsm/client/ba/bin/dsm.sys':
      ensure  => present,
      mode    => '0644',
      require => Package['ipnett-baas'];

    '/opt/tivoli/tsm/client/ba/bin/dsm.opt':
      ensure  => present,
      mode    => '0644',
      require => Package['ipnett-baas'];
  }

  if $enable_enroll {
    include ::ipnett_baas::enroll
  }

  if $enable_repo {
    include ::ipnett_baas::repo
  }

  service { 'dsmcad':
    ensure    => running,
    enable    => true,
    subscribe => File['/opt/tivoli/tsm/client/ba/bin/dsm.sys'];
  }
}
