# IPnett BaaS puppet module
class ipnett_baas (

  $access_token      = undef,
  $application       = 'filesystem',
  $compression       = true,
  $costcenter        = '1000',
  $deduplication     = true,
  $enable_repo       = true,
  $encryption        = false,
  $hostname          = $fqnd,
  $host_description  = $fqdn,
  $mail_address      = undef,
  $platform          = undef,

)
{
  $dependencies = [ 'ipnett-baas', 'ipnett-baas-setup' ]

  package { $dependencies:
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

  if $enable_repo {
    include ::ipnett_baas::repo
  }

  service { 'dsmcad':
    ensure    => running,
    enable    => true,
    subscribe => File['/opt/tivoli/tsm/client/ba/bin/dsm.sys'];
  }
}
