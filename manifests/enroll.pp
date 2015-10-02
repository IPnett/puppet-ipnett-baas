# IPnett BaaS enroller
class ipnett_baas::enroll (

  $access_token      = undef,
  $application       = 'filesystem',
  $compression       = true,
  $costcenter        = '1000',
  $deduplication     = true,
  $encryption        = false,
  $hostname          = $fqnd,
  $host_description  = $fqdn,
  $mail_address      = undef,
  $platform          = undef,

)
{
  package { 'ipnett-baas-setup':
    ensure => 'latest';
  }

  exec { 'ipnett-baas-setup':
    command => "/usr/bin/ipnet-baas-setup -H $hostname -a $application -t $access_token -c $costcenter -i $host_description -m $mail_address -p $platform",
    creates => "/opt/tivoli/tsm/client/ba/bin/dsm.sys",
    timeout => 400,
  }
}
