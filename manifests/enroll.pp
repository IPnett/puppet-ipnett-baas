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
}
