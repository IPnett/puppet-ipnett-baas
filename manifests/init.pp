# IPnett BaaS puppet module
class ipnett_baas (
    
  $access_key_id,
  $secret_access_key,
  $enable_repo = true,

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

  service { 'dsmcad':
    ensure    => running,
    enable    => true,
    subscribe => File['/opt/tivoli/tsm/client/ba/bin/dsm.sys'];
  }
}
