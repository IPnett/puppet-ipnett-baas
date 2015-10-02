# IPnett BaaS enroller
class ipnett_baas::enroll (

  $access_token      = undef,
  $application       = 'filesystem',
  $compression       = true,
  $costcenter        = '1000',
  $deduplication     = true,
  $encryption        = false,
  $hostname          = $::fqnd,
  $host_description  = $::fqdn,
  $mail_address      = undef,
  $platform          = undef,

)
{
  validate_string($access_token)
  validate_string($application)
  validate_bool($compression)
  validate_string($costcenter)
  validate_bool($deduplication)
  validate_bool($encryption)
  validate_string($hostname)
  validate_string($host_description)
  validate_string($mail_address)

  package { 'ipnett-baas-setup':
    ensure => 'latest';
  }

  exec { 'ipnett-baas-setup':
    command  => "/usr/bin/ipnet-baas-setup -H $hostname -a $application -t $access_token -c $costcenter -i $host_description -m $mail_address -p $platform",
    creates  => "/opt/tivoli/tsm/client/ba/bin/dsm.sys",
    timeout  => 400,
    requires => Package["ipnett-baas-setup"],
  }
}
