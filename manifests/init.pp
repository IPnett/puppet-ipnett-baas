# IPnett BaaS puppet module
class ipnett_baas
{
  $dependencies = [ 'ipnett-baas', 'ipnett-baas-setup' ]
  
  package { $dependencies:
      ensure => 'latest';
  }

  file {
    '/opt/tivoli/tsm/client/ba/bin/dsm.sys':
      ensure  => file,
      mode    => '0644',
      require => Package['ipnett-baas'],
      content => template('ipnett_baas/dsm.sys.erb');
    
    '/opt/tivoli/tsm/client/ba/bin/dsm.opt':
      ensure  => file,
      mode    => '0644',
      require => Package['ipnett-baas'],
      content => template('ipnett_baas/dsm.opt.erb');  
  }

  service { 'dsmcad':
    ensure    => running,
    enable    => true,
    subscribe => File['/opt/tivoli/tsm/client/ba/bin/dsm.sys'];
  }
}
