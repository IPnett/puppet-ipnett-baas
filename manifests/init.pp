# IPnett BaaS puppet module
class ipnett_baas (

  $access_token      = undef,
  $enable_repo       = true,
  $hostname          = $fqnd,
  $mail_address      = undef,
  $costcenter        = '1000',
  $host_description  = $fqdn,
  $compression       = 'ON',
  $deduplication     = 'ON',
  $platform          = undef,
  $application       = 'filesystem',

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
