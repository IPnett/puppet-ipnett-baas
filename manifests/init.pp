# IPnett BaaS puppet module
class ipnett_baas (

  $enable_repo       = true,
  $enable_enroll     = true,

)
{
  validate_bool($enable_repo)
  validate_bool($enable_enroll)

  if $enable_repo {
    include ::ipnett_baas::repo
  }

  package { 'ipnett-baas':
      ensure => 'latest';
  }

  if $enable_enroll {
    include ::ipnett_baas::enroll
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

  service { 'dsmcad':
    ensure    => running,
    enable    => true,
    subscribe => File['/opt/tivoli/tsm/client/ba/bin/dsm.sys'];
  }
}
