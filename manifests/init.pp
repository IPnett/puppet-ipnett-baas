# IPnett BaaS puppet module
class ipnett_baas (

  $access_token      = undef,
  $application       = 'filesystem',
  $compression       = 'ON',
  $costcenter        = '1000',
  $deduplication     = 'ON',
  $enable_repo       = true,
  $encryption        = 'OFF',
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
    include ::ipnett_bass::repo
  }

  service { 'dsmcad':
    ensure    => running,
    enable    => true,
    subscribe => File['/opt/tivoli/tsm/client/ba/bin/dsm.sys'];
  }
}
